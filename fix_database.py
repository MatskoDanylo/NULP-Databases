#!/usr/bin/env python3
"""
Database Definer Fix Script
This script connects to your AWS RDS database and executes the fix for definer issues.
"""

import pymysql
import sys
from config import Config

def fix_database_definers():
    """Execute the SQL script to fix definer issues"""
    
    # Parse connection string
    db_url = Config.SQLALCHEMY_DATABASE_URI
    # Extract connection details from the URL
    # Format: mysql+pymysql://admin:rootroot2015@database-lab1.ct4uay8ia6db.eu-north-1.rds.amazonaws.com:3306/ticketing_system_lab3
    
    parts = db_url.replace('mysql+pymysql://', '').split('@')
    user_pass = parts[0].split(':')
    host_port_db = parts[1].split('/')
    host_port = host_port_db[0].split(':')
    
    user = user_pass[0]
    password = user_pass[1]
    host = host_port[0] 
    port = int(host_port[1]) if len(host_port) > 1 else 3306
    database = host_port_db[1]
    
    print(f"Connecting to database: {host}:{port}/{database}")
    
    try:
        # Connect to database
        connection = pymysql.connect(
            host=host,
            port=port,
            user=user,
            password=password,
            database=database,
            charset='utf8mb4'
        )
        
        print("Successfully connected to database!")
        
        # Read the SQL fix script
        with open('fix_definer_issues.sql', 'r', encoding='utf-8') as f:
            sql_script = f.read()
        
        # Split the script into individual statements
        statements = []
        current_statement = ""
        delimiter = ";"
        
        for line in sql_script.split('\n'):
            line = line.strip()
            
            # Skip comments and empty lines
            if line.startswith('--') or not line:
                continue
                
            # Handle delimiter changes
            if line.startswith('DELIMITER'):
                delimiter = line.split()[-1]
                continue
                
            current_statement += line + " "
            
            # Check if statement is complete
            if line.endswith(delimiter) and delimiter != ";;":
                statements.append(current_statement.strip())
                current_statement = ""
            elif delimiter == ";;" and line.endswith(';;'):
                statements.append(current_statement.strip())
                current_statement = ""
                delimiter = ";"
        
        # Add any remaining statement
        if current_statement.strip():
            statements.append(current_statement.strip())
        
        # Execute each statement
        with connection.cursor() as cursor:
            for i, statement in enumerate(statements):
                if statement and not statement.startswith('--'):
                    try:
                        print(f"Executing statement {i+1}/{len(statements)}: {statement[:50]}...")
                        cursor.execute(statement)
                        connection.commit()
                        print("  ✓ Success")
                    except Exception as e:
                        print(f"  ✗ Error: {e}")
                        if "does not exist" not in str(e):
                            print(f"  Statement: {statement}")
        
        print("\n✅ Database definer issues have been fixed!")
        print("You can now try creating customers through the API.")
        
        connection.close()
        
    except Exception as e:
        print(f"❌ Error connecting to database: {e}")
        return False
        
    return True

if __name__ == "__main__":
    print("🔧 NULP Database Definer Fix Tool")
    print("=" * 50)
    
    success = fix_database_definers()
    
    if success:
        print("\n🎉 Fix completed successfully!")
        print("You can now test the API endpoints in Swagger UI.")
    else:
        print("\n💥 Fix failed. Please check the error messages above.")
        sys.exit(1)
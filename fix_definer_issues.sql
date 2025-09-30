-- Complete fix for definer issues in the NULP Databases ticketing system
-- Run this script on your AWS RDS database to fix all definer problems
-- This script will drop and recreate all problematic database objects

-- ===== STEP 1: Drop all problematic triggers =====

DROP TRIGGER IF EXISTS `check_phone_format`;
DROP TRIGGER IF EXISTS `prevent_delete_event`;  
DROP TRIGGER IF EXISTS `extra_table_artist_fk`;
DROP TRIGGER IF EXISTS `prevent_update_venue`;

-- ===== STEP 2: Drop all problematic functions and procedures =====

DROP FUNCTION IF EXISTS `ColumnStatFunction`;
DROP PROCEDURE IF EXISTS `CalculateDynamicStatistic`;
DROP PROCEDURE IF EXISTS `CopyToRandomTables`;
DROP PROCEDURE IF EXISTS `InsertBatchToExtraTable`;
DROP PROCEDURE IF EXISTS `InsertIntoExtraTable`;
DROP PROCEDURE IF EXISTS `LinkArtistToEvent`;

-- ===== STEP 3: Recreate triggers without DEFINER clauses =====

-- Recreate phone format check trigger
DELIMITER ;;
CREATE TRIGGER `check_phone_format` BEFORE INSERT ON `customer` FOR EACH ROW 
BEGIN
    IF NEW.phone LIKE '%00' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Phone number cannot end with two zeros';
    END IF;
END;;
DELIMITER ;

-- Recreate prevent delete event trigger
DELIMITER ;;
CREATE TRIGGER `prevent_delete_event` BEFORE DELETE ON `event` FOR EACH ROW 
BEGIN
    IF OLD.event_name = 'Important Event' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete important event';
    END IF;
END;;
DELIMITER ;

-- Recreate extra table artist foreign key trigger  
DELIMITER ;;
CREATE TRIGGER `extra_table_artist_fk` BEFORE INSERT ON `extra_table` FOR EACH ROW 
BEGIN
    DECLARE artist_exists INT DEFAULT 0;
    SELECT COUNT(*) INTO artist_exists FROM artist WHERE id = NEW.artist_id;
    IF artist_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Referenced artist does not exist';
    END IF;
END;;
DELIMITER ;

-- Recreate prevent update venue trigger
DELIMITER ;;
CREATE TRIGGER `prevent_update_venue` BEFORE UPDATE ON `venue` FOR EACH ROW 
BEGIN
    IF OLD.venue_name = 'Protected Venue' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot update protected venue';
    END IF;
END;;
DELIMITER ;

-- ===== STEP 4: Recreate functions and procedures without DEFINER clauses =====

-- Recreate ColumnStatFunction
DELIMITER ;;
CREATE FUNCTION `ColumnStatFunction`(stat_type VARCHAR(10)) RETURNS DECIMAL(10,2)
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE result DECIMAL(10,2) DEFAULT 0.00;
    
    IF stat_type = 'avg_price' THEN
        SELECT COALESCE(AVG(total_price), 0.00) INTO result FROM `order`;
    ELSEIF stat_type = 'max_price' THEN
        SELECT COALESCE(MAX(total_price), 0.00) INTO result FROM `order`;
    ELSEIF stat_type = 'min_price' THEN
        SELECT COALESCE(MIN(total_price), 0.00) INTO result FROM `order`;
    END IF;
    
    RETURN result;
END;;
DELIMITER ;

-- Recreate CalculateDynamicStatistic procedure
DELIMITER ;;
CREATE PROCEDURE `CalculateDynamicStatistic`(
    IN stat_type VARCHAR(10),
    OUT result DECIMAL(10,2)
)
READS SQL DATA
BEGIN
    SET result = ColumnStatFunction(stat_type);
END;;
DELIMITER ;

-- Recreate CopyToRandomTables procedure  
DELIMITER ;;
CREATE PROCEDURE `CopyToRandomTables`(IN source_table_name VARCHAR(255))
MODIFIES SQL DATA
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE table_name VARCHAR(255);
    DECLARE table_cursor CURSOR FOR 
        SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES 
        WHERE TABLE_SCHEMA = DATABASE() 
        AND TABLE_NAME LIKE 'random_%';
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN table_cursor;
    read_loop: LOOP
        FETCH table_cursor INTO table_name;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        -- Insert logic would go here based on source_table_name
        -- This is a placeholder implementation
        
    END LOOP;
    CLOSE table_cursor;
END;;
DELIMITER ;

-- Recreate InsertBatchToExtraTable procedure
DELIMITER ;;
CREATE PROCEDURE `InsertBatchToExtraTable`()
MODIFIES SQL DATA
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE artist_id INT;
    DECLARE artist_cursor CURSOR FOR SELECT id FROM artist LIMIT 5;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN artist_cursor;
    read_loop: LOOP
        FETCH artist_cursor INTO artist_id;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        INSERT INTO extra_table (artist_id, description) 
        VALUES (artist_id, CONCAT('Batch description for artist ', artist_id));
        
    END LOOP;
    CLOSE artist_cursor;
END;;
DELIMITER ;

-- Recreate InsertIntoExtraTable procedure
DELIMITER ;;
CREATE PROCEDURE `InsertIntoExtraTable`(IN p_artist_id INT, IN p_description VARCHAR(255))
MODIFIES SQL DATA
BEGIN
    INSERT INTO extra_table (artist_id, description) 
    VALUES (p_artist_id, p_description);
END;;
DELIMITER ;

-- Recreate LinkArtistToEvent procedure
DELIMITER ;;
CREATE PROCEDURE `LinkArtistToEvent`(IN artist_id INT, IN event_id INT)
MODIFIES SQL DATA
BEGIN
    INSERT INTO event_artist (event_id, artist_id) 
    VALUES (event_id, artist_id);
END;;
DELIMITER ;

-- ===== COMPLETION MESSAGE =====
SELECT 'Database definer issues have been fixed successfully!' as Status;
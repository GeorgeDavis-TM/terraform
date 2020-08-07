CREATE DATABASE IF NOT EXISTS tm_cgw_db;

SET GLOBAL validate_password_length = 1;
SET GLOBAL validate_password_mixed_case_count = 0;
SET GLOBAL validate_password_number_count = 0;
SET GLOBAL validate_password_special_char_count = 0;

CREATE USER IF NOT EXISTS 'tm_db_user'@'localhost' IDENTIFIED BY 'tm_db_pass';
CREATE USER IF NOT EXISTS 'tm_db_user'@'%' IDENTIFIED BY 'tm_db_pass';

GRANT ALL ON tm_cgw_db.* TO 'tm_db_user'@'localhost';
GRANT ALL ON tm_cgw_db.* TO 'tm_db_user'@'%';

USE tm_cgw_db;

CREATE TABLE IF NOT EXISTS tbl_cgw_az_resources (
    cgw_az_uuid VARCHAR(15) PRIMARY KEY NOT NULL,           
    cgw_az_public_ip VARCHAR(25),
    cgw_az_nic VARCHAR(40) NOT NULL,
    cgw_az_vm VARCHAR(40) NOT NULL,
    cgw_az_sc VARCHAR(50) NOT NULL,          
    cgw_az_ssh_sg VARCHAR(50) NOT NULL
);

DROP PROCEDURE IF EXISTS CgwAzUpdateOrInsert;

DELIMITER $$
CREATE PROCEDURE CgwAzUpdateOrInsert(
    IN _cgw_az_uuid VARCHAR(15),           
    IN _cgw_az_public_ip VARCHAR(25),
    IN _cgw_az_nic VARCHAR(40),
    IN _cgw_az_vm VARCHAR(40),
    IN _cgw_az_sc VARCHAR(50),          
    IN _cgw_az_ssh_sg VARCHAR(50)
)
BEGIN
  IF EXISTS (SELECT cgw_az_uuid FROM tbl_cgw_az_resources WHERE cgw_az_uuid = _cgw_az_uuid) THEN
    UPDATE tbl_cgw_az_resources SET
        cgw_az_public_ip = _cgw_az_public_ip
        cgw_az_nic = _cgw_az_nic
        cgw_az_vm = _cgw_az_vm
        cgw_az_sc = _cgw_az_sc
        cgw_az_ssh_sg = _cgw_az_ssh_sg
    WHERE 
        cgw_az_uuid = _cgw_az_uuid;
  ELSE 
    INSERT INTO tbl_cgw_az_resources (`cgw_az_uuid`, `cgw_az_public_ip`, `cgw_az_nic`, `cgw_az_vm`, `cgw_az_sc`, `cgw_az_ssh_sg`) VALUES (_cgw_az_uuid, _cgw_az_public_ip, _cgw_az_nic, _cgw_az_vm, _cgw_az_sc, _cgw_az_ssh_sg);
  END IF;
END $$
DELIMITER ;

GRANT EXECUTE ON PROCEDURE tm_cgw_db.CgwAzUpdateOrInsert TO 'tm_db_user'@'localhost';  
GRANT EXECUTE ON PROCEDURE tm_cgw_db.CgwAzUpdateOrInsert TO 'tm_db_user'@'%'; 

CALL CgwAzUpdateOrInsert("2cu2f9ol", "52.233.0.61", "/subscriptions/18cb46c3-ea58-41c2-8cc6-71d8662f1203/resourceGroups/cloudone/providers/Microsoft.Network/networkInterfaces/cgw-az-nic-2cu2f9ol", "/subscriptions/18cb46c3-ea58-41c2-8cc6-71d8662f1203/resourceGroups/cloudone/providers/Microsoft.Compute/virtualMachines/cgw-az-vm-2cu2f9ol", "https://cgwazsa2cu2f9ol.blob.core.windows.net/cgw-az-sc-2cu2f9ol", "/subscriptions/18cb46c3-ea58-41c2-8cc6-71d8662f1203/resourceGroups/cloudone/providers/Microsoft.Network/networkSecurityGroups/cgw-az-ssh-sg-2cu2f9ol");
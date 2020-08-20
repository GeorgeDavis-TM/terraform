CREATE DATABASE IF NOT EXISTS tm_cgw_db;

SET GLOBAL validate_password_length = 1;
SET GLOBAL validate_password_mixed_case_count = 0;
SET GLOBAL validate_password_number_count = 0;
SET GLOBAL validate_password_special_char_count = 0;

CREATE OR REPLACE USER IF NOT EXISTS 'tm_db_user'@'localhost' IDENTIFIED BY 'tm_db_pass';
CREATE OR REPLACE USER IF NOT EXISTS 'tm_db_user'@'%' IDENTIFIED BY 'tm_db_pass';

GRANT ALL ON tm_cgw_db.* TO 'tm_db_user'@'localhost';
GRANT ALL ON tm_cgw_db.* TO 'tm_db_user'@'%';

USE tm_cgw_db;

CREATE TABLE IF NOT EXISTS tbl_cgw_aws_resources (
    cgw_aws_uuid VARCHAR(15) PRIMARY KEY NOT NULL,           
    cgw_aws_instance_public_ip VARCHAR(25),
    cgw_aws_instance_id VARCHAR(40) NOT NULL,
    cgw_aws_vol VARCHAR(40) NOT NULL,
    cgw_aws_s3_bucket VARCHAR(50) NOT NULL,          
    cgw_aws_iam_user VARCHAR(50) NOT NULL,           
    cgw_aws_iam_user_password VARCHAR(500) NOT NULL, 
    cgw_aws_iam_role VARCHAR(50) NOT NULL,     
    cgw_aws_iam_instance_profile VARCHAR(50) NOT NULL,
    cgw_aws_iam_policy VARCHAR(50) NOT NULL,  
    cgw_aws_ssh_sg VARCHAR(50) NOT NULL
);

DROP PROCEDURE IF EXISTS CgwAwsUpdateOrInsert;

DELIMITER $$
CREATE PROCEDURE CgwAwsUpdateOrInsert(
    IN _cgw_aws_uuid VARCHAR(15),           
    IN _cgw_aws_instance_public_ip VARCHAR(25),
    IN _cgw_aws_instance_id VARCHAR(40),
    IN _cgw_aws_vol VARCHAR(40),
    IN _cgw_aws_s3_bucket VARCHAR(50),          
    IN _cgw_aws_iam_user VARCHAR(50),           
    IN _cgw_aws_iam_user_password VARCHAR(500), 
    IN _cgw_aws_iam_role VARCHAR(50),     
    IN _cgw_aws_iam_instance_profile VARCHAR(50),
    IN _cgw_aws_iam_policy VARCHAR(50),  
    IN _cgw_aws_ssh_sg VARCHAR(50)
)
BEGIN
  IF EXISTS (SELECT cgw_aws_uuid FROM tbl_cgw_aws_resources WHERE cgw_aws_uuid = _cgw_aws_uuid) THEN
    UPDATE tbl_cgw_aws_resources SET
        cgw_aws_instance_public_ip = _cgw_aws_instance_public_ip,
        cgw_aws_instance_id = _cgw_aws_instance_id,
        cgw_aws_vol = _cgw_aws_vol,
        cgw_aws_s3_bucket = _cgw_aws_s3_bucket,
        cgw_aws_iam_user = _cgw_aws_iam_user,
        cgw_aws_iam_user_password = _cgw_aws_iam_user_password,
        cgw_aws_iam_role = _cgw_aws_iam_role,
        cgw_aws_iam_instance_profile = _cgw_aws_iam_instance_profile,
        cgw_aws_iam_policy = _cgw_aws_iam_policy,
        cgw_aws_ssh_sg = _cgw_aws_ssh_sg
    WHERE 
        cgw_aws_uuid = _cgw_aws_uuid;
  ELSE 
    INSERT INTO tbl_cgw_aws_resources (`cgw_aws_uuid`, `cgw_aws_instance_public_ip`, `cgw_aws_instance_id`, `cgw_aws_vol`, `cgw_aws_s3_bucket`, `cgw_aws_iam_user`, `cgw_aws_iam_user_password`, `cgw_aws_iam_role`, `cgw_aws_iam_instance_profile`, `cgw_aws_iam_policy`, `cgw_aws_ssh_sg`) VALUES (_cgw_aws_uuid, _cgw_aws_instance_public_ip, _cgw_aws_instance_id, _cgw_aws_vol, _cgw_aws_s3_bucket, _cgw_aws_iam_user, _cgw_aws_iam_user_password, _cgw_aws_iam_role, _cgw_aws_iam_instance_profile, _cgw_aws_iam_policy, _cgw_aws_ssh_sg);
  END IF;
END $$
DELIMITER ;

GRANT EXECUTE ON PROCEDURE tm_cgw_db.CgwAwsUpdateOrInsert TO 'tm_db_user'@'localhost';  
GRANT EXECUTE ON PROCEDURE tm_cgw_db.CgwAwsUpdateOrInsert TO 'tm_db_user'@'%'; 

CALL CgwAwsUpdateOrInsert("fbn7v1tr", "18.224.58.61", "i-0f56a98240142af5c", "vol-0a9548047fd0d9b90", "cgw-aws-s3-bucket-fbn7v1tr.s3.amazonaws.com", "cgw-aws-iam-user-fbn7v1tr"," wcBMA0sO1vRsBNNAAQgAF9amXx3s1YkR/VtRk5uC6nD6SM2AA7rgu4oqnn8t47cmzxdLaPkjM0EyZz1hUYbMMd2x36YlYKD6f6VtizMC8RfTkNodY4HC27KduEs9j0tN1EP/Nz5EBL2siS0SBDcsQ+BNURZWwWRBVbXBFIkn77Rjpg66rovO4JAHYksQU1KMfEzY8E34XS7PfuHf6V8XfaBUCet/qosJvnqd12xwEcYOqnB90LYT/ty9TJ5n+d8nZIAuhra1OQqXLbpOhkUTMIdWYe4k3lxCxJiXNnf8L/8UjOhqCokEF2iNi8zIizPajtwXy7Gzf9GNgb+YTWmnox9O9Hs0zT8PltqiE/L1VtLgAeSucJeuUaXG8VmdB1J6+/lY4UNk4GTgy+GKeuB+4mfZiB3gmeRuVjr8DJjId5/HnwtaqA8c4JviH1Jx4+D/5FUH9sH+gaJvdS/UUP9EZHDilKQOk+Gz6QA=", "cgw-aws-iam-role-fbn7v1tr", "cgw-aws-iam-instance-profile-fbn7v1tr", "cgw-aws-iam-policy-fbn7v1tr", "cgw-aws-ssh-sg-fbn7v1tr");
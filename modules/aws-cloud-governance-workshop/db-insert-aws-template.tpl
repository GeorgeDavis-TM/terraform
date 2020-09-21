CREATE DATABASE IF NOT EXISTS tm_cgw_db;

-- SET GLOBAL validate_password_length = 1;
-- SET GLOBAL validate_password_mixed_case_count = 0;
-- SET GLOBAL validate_password_number_count = 0;
-- SET GLOBAL validate_password_special_char_count = 0;

-- CREATE USER IF NOT EXISTS 'tm_db_user'@'localhost' IDENTIFIED BY 'tm_db_pass';
-- CREATE USER IF NOT EXISTS 'tm_db_user'@'%' IDENTIFIED BY 'tm_db_pass';

-- GRANT ALL ON tm_cgw_db.* TO 'tm_db_user'@'localhost';
-- GRANT ALL ON tm_cgw_db.* TO 'tm_db_user'@'%';

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
    cgw_aws_ssh_sg VARCHAR(50) NOT NULL,
    cgw_aws_kms_key VARCHAR(200) NOT NULL,
    cgw_aws_elb VARCHAR(50) NOT NULL,
    cgw_aws_sns_topic VARCHAR(200) NOT NULL,
    cgw_aws_iam_user_password_decrypted VARCHAR(100) NOT NULL
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
    IN _cgw_aws_ssh_sg VARCHAR(50),
    IN _cgw_aws_kms_key VARCHAR(100),
    IN _cgw_aws_elb VARCHAR(100),
    IN _cgw_aws_sns_topic VARCHAR(200),
    IN _cgw_aws_iam_user_password_decrypted VARCHAR(100)
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
        cgw_aws_ssh_sg = _cgw_aws_ssh_sg,
        cgw_aws_kms_key = _cgw_aws_kms_key,
        cgw_aws_elb = _cgw_aws_elb,
        cgw_aws_sns_topic = _cgw_aws_sns_topic,
        cgw_aws_iam_user_password_decrypted = _cgw_aws_iam_user_password_decrypted
    WHERE 
        cgw_aws_uuid = _cgw_aws_uuid;
  ELSE 
    INSERT INTO tbl_cgw_aws_resources (`cgw_aws_uuid`, `cgw_aws_instance_public_ip`, `cgw_aws_instance_id`, `cgw_aws_vol`, `cgw_aws_s3_bucket`, `cgw_aws_iam_user`, `cgw_aws_iam_user_password`, `cgw_aws_iam_role`, `cgw_aws_iam_instance_profile`, `cgw_aws_iam_policy`, `cgw_aws_ssh_sg`, `cgw_aws_kms_key`, `cgw_aws_elb`, `cgw_aws_sns_topic`, `cgw_aws_iam_user_password_decrypted`) VALUES (_cgw_aws_uuid, _cgw_aws_instance_public_ip, _cgw_aws_instance_id, _cgw_aws_vol, _cgw_aws_s3_bucket, _cgw_aws_iam_user, _cgw_aws_iam_user_password, _cgw_aws_iam_role, _cgw_aws_iam_instance_profile, _cgw_aws_iam_policy, _cgw_aws_ssh_sg, _cgw_aws_kms_key, _cgw_aws_elb, _cgw_aws_sns_topic, _cgw_aws_iam_user_password_decrypted);
  END IF;
END $$
DELIMITER ;

GRANT EXECUTE ON PROCEDURE tm_cgw_db.CgwAwsUpdateOrInsert TO 'tm_db_user'@'localhost';  
GRANT EXECUTE ON PROCEDURE tm_cgw_db.CgwAwsUpdateOrInsert TO 'tm_db_user'@'%'; 

CALL CgwAwsUpdateOrInsert("${cgw-aws-uuid}", "${cgw-aws-instance-public-ip}", "${cgw-aws-instance-id}", "${cgw-aws-vol}", "${cgw-aws-s3-bucket}", "${cgw-aws-iam-user}", "${cgw-aws-iam-user-password}", "${cgw-aws-iam-role}", "${cgw-aws-iam-instance-profile}", "${cgw-aws-iam-policy}", "${cgw-aws-ssh-sg}", "${cgw-aws-kms-key}", "${cgw-aws-elb}", "${cgw-aws-sns-topic}", "${cgw-aws-iam-user-password-decrypted}");

DROP PROCEDURE IF EXISTS spCgwAwsAddUserLogin;

DELIMITER $$
CREATE PROCEDURE spCgwAwsAddUserLogin(
    IN _user_team_uuid VARCHAR(15),           
    IN _user_pass VARCHAR(500)
)
BEGIN
  SET @user_name = CONCAT('cgw-aws-', _user_team_uuid);
  IF EXISTS (SELECT user_name FROM tbl_users WHERE user_team_uuid = _user_team_uuid) THEN
    UPDATE tbl_users SET
        user_name = @user_name,
        user_pass = _user_pass,
        user_platform = 'aws'
    WHERE 
        user_team_uuid = _user_team_uuid;
  ELSE 
    INSERT INTO tbl_users (`user_name`, `user_pass`, `user_team_uuid`, `user_platform`) VALUES (@user_name, _user_pass, _user_team_uuid, 'aws');
  END IF;
END $$
DELIMITER ;

GRANT EXECUTE ON PROCEDURE tm_cgw_db.spCgwAwsAddUserLogin TO 'tm_db_user'@'localhost';  
GRANT EXECUTE ON PROCEDURE tm_cgw_db.spCgwAwsAddUserLogin TO 'tm_db_user'@'%'; 

CALL spCgwAwsAddUserLogin("${cgw-aws-uuid}", "${cgw-aws-iam-user-password-decrypted}");
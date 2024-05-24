local table_exist = MySQL.query.await('SHOW TABLES LIKE ?', { 'ars_login' })

if #table_exist > 0 then return end


MySQL.query([[
    CREATE TABLE IF NOT EXISTS `ars_login` (
        `identifier` varchar(46) NOT NULL DEFAULT '',
        `pg` int(11) NOT NULL,
        PRIMARY KEY (`identifier`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
]])

print("The [^4ars_login^7] table in db has been created correctly")

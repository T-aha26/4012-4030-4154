<?php
namespace app\config;

use PDO;

class Connexion
{
    private static $instance = null;

    public static function getInstance(): PDO
    {
        if (self::$instance === null) {
            $host = 'localhost';
            $dbname = 'moto';
            $user = 'root';
            $pass = '';

            try {
                self::$instance = new PDO(
    "mysql:host=127.0.0.1;port=3306;dbname=taximoto;charset=utf8",
    "root",
    "",
    [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES => false,
    ]
);

            } catch (\PDOException $e) {
                die("Erreur connexion DB: " . $e->getMessage());
            }
        }
        return self::$instance;
    }
}

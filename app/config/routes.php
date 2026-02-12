<?php

use app\controllers\ReportController;
use app\controllers\CourseController;
use app\middlewares\SecurityHeadersMiddleware;
use flight\Engine;
use flight\net\Router;

/** 
 * @var Router $router 
 * @var Engine $app
 */

$router->group('', function(Router $router) use ($app) {

    // Page d'accueil
    $router->get('/', function() use ($app) {
        header('Location: /report');
        exit;
    });

    // Rapport complet (totaux + détails)
    $router->get('/report', [ReportController::class, 'index']);

    // Routes course API
    $router->group('/api', function() use ($router) {
        $router->get('/course/add', [CourseController::class, 'add']);
        $router->post('/course/save', [CourseController::class, 'save']);
    });

}, [ SecurityHeadersMiddleware::class ]);

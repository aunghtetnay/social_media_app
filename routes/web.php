<?php

use App\Models\User;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Route::get('/user-create', function () {
    User::create([
        'name' => 'han', 'email' => 'cho', 'password' => '123456', 'system_status' => 'active', 'profile_image_id' => ''
    ]);

    echo 'done';
});

Route::get('/truncate', function () {
    User::truncate();
    echo 'done';
});



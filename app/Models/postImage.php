<?php

namespace App\Models;

use App\Helpers\Uuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class postImage extends Model
{
    use HasFactory, Uuids;


    public function post()
    {
        // return [];
    }
}

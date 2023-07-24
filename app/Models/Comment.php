<?php

namespace App\Models;

use App\Helpers\Uuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Comment extends Model
{
    use HasFactory, SoftDeletes, Uuids;

    public $incrementing = false;
    protected $keyType = 'string';

    protected $fillable = [ 'user_id', 'post_id', 'contents', 'lookup_id'];

    

}

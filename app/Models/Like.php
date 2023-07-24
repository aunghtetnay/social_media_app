<?php

namespace App\Models;

use App\Helpers\Uuids;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Like extends Model
{
    use HasFactory, SoftDeletes, Uuids;

    public $incrementing = false;
    protected $keyType = 'string';

    protected $fillable = [ 'user_id', 'post_id', 'comment_id'];

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }
    
}

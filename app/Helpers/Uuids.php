<?php

namespace App\Helpers;

use Illuminate\Support\Str;

trait Uuids {

    protected static function boot()
    {
        parent::boot();

        static::creating(function ($model) {
            $model->{$model->getKeyName()} = (string) Str::uuid();
        });
    }

}
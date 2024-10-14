<?php 

namespace App\Model;


class User extends BaseModel {
    const PROFILE_USER = 2;
    const PROFILE_ADMIN = 1; 
    const DEFAULT_LANGUAGE = "Português";

	protected $table = 'empresas';
    protected $picture_link = '';

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'nome',
        'username',
        'email', 
        'password',
        'observacoes',
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password', 'remember_token',
    ];

    public function pictureLink($request) {
     return $this->picture_link =  $request->getUri()->getBaseUrl().'/'.$_ENV['STORAGE_PATH'].$this->picture;
    }


}
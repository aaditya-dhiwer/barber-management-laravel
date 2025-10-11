<?php

namespace App\Providers;


use Illuminate\Support\Facades\Gate;
use Illuminate\Foundation\Support\Providers\AuthServiceProvider as ServiceProvider;
use Illuminate\Auth\Access\Response;

class AuthServiceProvider extends ServiceProvider
{
    /**
     * The model to policy mappings for the application.
     *
     * @var array<class-string, class-string>
     */
    protected $policies = [
        //
    ];

    /**
     * Register any authentication / authorization services.
     */
    public function boot()
    {
        $this->registerPolicies();

        // Gate::define('isOwner', function ($user) {
        //     return $user->role === 'owner';
        // });

        // Gate::define('isCustomer', function ($user) {
        //     return $user->role === 'customer';
        // });

        Gate::define('isOwner', function ($user) {
            return $user->role === 'owner'
                ? Response::allow()
                : Response::deny('Only owners can access this resource.');
        });

        Gate::define('isCustomer', function ($user) {
            return $user->role === 'customer'
                ? Response::allow()
                : Response::deny('Only customers can access this resource.');
        });
    }
}

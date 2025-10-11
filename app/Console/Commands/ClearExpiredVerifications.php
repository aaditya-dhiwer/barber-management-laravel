<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\PendingVerification;

class ClearExpiredVerifications extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'app:clear-expired-verifications';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Command description';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        PendingVerification::where('expires_at', '<', now())->delete();
    }
}

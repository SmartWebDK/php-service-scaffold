<?php
/** @noinspection PhpIllegalPsrClassPathInspection */
declare(strict_types = 1);

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

/**
 * @author Nicolai Agersbæk <na@smartweb.dk>
 */
class CreateWebhooksTable extends Migration
{
    
    /**
     * Run the migrations.
     */
    public function up() : void
    {
        Schema::create(
            'someMainTable',
            function (Blueprint $table) {
                $table->bigIncrements('id');
                $table->dateTimeTz('created_at');
                $table->dateTimeTz('updated_at');
            }
        );
    }
    
    /**
     * Reverse the migrations.
     */
    public function down() : void
    {
        Schema::dropIfExists('webhooks');
    }
}

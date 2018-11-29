<?php
declare(strict_types = 1);

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

/**
 * @author Nicolai Agersbæk <na@smartweb.dk>
 */
class CreateLogsTable extends Migration
{
    
    /**
     * Run the migrations.
     */
    public function up() : void
    {
        Schema::create(
            'logs',
            function (Blueprint $table) {
                $table->bigIncrements('id');
                $table->unsignedBigInteger('webhook_id');
                $table->string('solution_id', 50);
                $table->string('source');
                $table->string('hash_key');
                $table->string('topic', 100);
                $table->string('address');
                $table->dateTimeTz('created_at');
            }
        );
    }
    
    /**
     * Reverse the migrations.
     */
    public function down() : void
    {
        Schema::dropIfExists('logs');
    }
}

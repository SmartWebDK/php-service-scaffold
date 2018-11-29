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
            'webhooks',
            function (Blueprint $table) {
                $table->bigIncrements('id');
                $table->string('solution_id', 50);
                $table->string('source');
                $table->string('hash_key');
                $table->string('topic', 100);
                $table->string('address');
                $table->dateTimeTz('created_at');
                $table->dateTimeTz('updated_at');
                
                $table->index(['solution_id', 'topic'], 'solution_topic_idx');
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

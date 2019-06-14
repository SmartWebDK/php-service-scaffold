<?php
declare(strict_types = 1);


namespace {{.Data.namespace}}\Listeners;

use Google\Protobuf\Internal\Message;
use SmartWeb\Service\Listeners\NatsStreamingEventHandler;

/**
 * Sample event handler/listener that handles instances of the dummy `SampleEvent`.
 *
 * @author {{.Author.Name}} <{{.Author.Email}}>
 */
class SampleEventHandler extends NatsStreamingEventHandler
{

    /**
     * Get the fully-qualified class name of events expected by this subscriber.
     * This **MUST** be an instantiable class, which means that interfaces or
     * abstract classes are never considered valid.
     *
     * @return string
     */
    public function expects() : string
    {
        return 'SmartWeb\Protobuf\Dummy\Event\SampleEvent';
    }

    /**
     * @param Message $event
     */
    public function handleEvent(Message $event) : void
    {
        /** @var SmartWeb\Protobuf\Category\Event\SomeEvent $event */
        // FIXME: Do something with the event!
    }
}

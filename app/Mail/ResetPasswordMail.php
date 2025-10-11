<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;

class ResetPasswordMail extends Mailable
{
    use Queueable, SerializesModels;

    public string $url;

    /**
     * Create a new message instance.
     */
    public function __construct(string $url)
    {
        $this->url = $url;
    }

    /**
     * Define the email envelope (subject, from, etc.)
     */
    public function envelope(): Envelope
    {
        return new Envelope(
            subject: 'Reset Your Password',
        );
    }

    /**
     * Define the email content (view, markdown, etc.)
     */
    public function content(): Content
    {
        return new Content(
            view: 'emails.reset-password', // Blade template
            with: [
                'url' => $this->url,
            ],
        );
    }

    /**
     * Define attachments (not needed here)
     */
    public function attachments(): array
    {
        return [];
    }
}

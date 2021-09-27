--
title: Shortcuts and Roadblocks
tag: colophon
--

One thing I want to do with the workflow on this blog is the ability to upload posts and images to the Inbound Bucket from an iPad or iPhone. I poked around the App Stoe for S3 clients, but nothing jumped out. So, I thought I'd try to make my own with Shortcuts!

I started reading through the [S3 PUT Object](https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutObject.html), [AWS SigV4](https://docs.aws.amazon.com/AmazonS3/latest/API/sigv4-auth-using-authorization-header.html), and [Signature Calculations for the Authorization Header](https://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-header-based-auth.html) documents form AWS, as well as the [Request your first API in Shortcuts on iPhone or iPad](https://support.apple.com/guide/shortcuts/request-your-first-api-apd58d46713f/ios) from Apple.

Things were looking promising, especiually when I saw that the "Generate Hash" Shortcut action supports SHA256! I figured, with enough tapping, typing, and swiping, I'd have a decent shortcut in no time. With a little extra polish, it would be something to share with the world.

Unfortunatley, I need HMAC_SHA256, so I can seed the hash with various keys. Nothing in Shortcuts seems to provide this. Roadblock Number One.

Then, looking through the Shortcut Actions, I found the [Run JavaScript on Webpage](https://support.apple.com/guide/shortcuts/intro-to-the-run-javascript-on-webpage-action-apd218e2187d/ios) Action. Could I web-pack the aws-s3 API into a helper for Shortcuts? Short answer, no. This action can only be run on web pages, and only from Safari's Share Sheet. Roadblock Number Two.

I think Shortcuts just isn't the right tool for the job. For the short-term , I can upload through the AWS/S3 Console from an iPad. Longer-term, I'll build an admin console into the blog itself, support Create, Replace, Update and Delete (CRUD) for the Inbound Bucket.
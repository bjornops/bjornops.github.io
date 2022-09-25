---
title: "A Celebration of Files"
last_modified_at: 2022-09-25T17:12:02+02:00
excerpt: "Files. Files everywhere."
categories:
  - Blog
  - Tech
tags:
  - General
---

In modern software development, files are often seen as a nuisance and mostly taken for granted.
I would like to state my appreciation of files.

Files are the most basic part of any software system.
However, being basic does not mean unuseful.

The first great example of this is databases.
They seem complex and scary, and they kind of are from the query side.
However, the underlying technology is quite simple.
Databases are files.
The book [*Designing Data Intensive Applications*](https://www.oreilly.com/library/view/designing-data-intensive-applications/9781491903063/) describes the construction of a database, and also clearly shows that the database's function is to manipulate files.
And guess what.
Kafka and other message queue solutions are also based on files.

The great mystery of data lakes share the same illution of mystery, but they are as simple as folders and files.
I'm still not trying to diminish the complexity and effort going into the software that provides an interface to query and make the information in the files available.
At the same time, they utilize the power and simplicity of files.

From an application perspective, writing files to disk is ubiquitous.
Every language and framework support it and these files can be immensely useful.

Computations are expensive and time consuming, so when the result probably will be reused, storing them to a file can be very efficient.
Nobody said that a web API must return information through a live application.
A status page, subscription prices or other relatively static information can easily be written to a file and be distributed by a CDN, yielding lower trafic on the servers and lower latency for the client, as the information is located closer to them.

This web page is also provided that way, and consists only of flat packed files with no overhead for the client to download a web application and rendering the content.
A slightly greener website!

Another example of a file application is to reduce an application's dependencies.
If the application outputs fire-and-forget events, such as logging, the events can be written to a file instead of sending the event directly to the recipient, or worse recipients.
The application code will be leaner without including the libraries and configuration to distribute these events.
Additionally, the events are also buffered in the file, in case the recipient application is unavailable, and not affecting the performance of the main application.

Of course, files are not the solution to every software problem, but they are so extremely useful and I wanted to give a shoutout to the largely unnoticed backbone of the digital age.

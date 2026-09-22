# Project Overview

This repository contains a prototype application for discovering nearby food deals.

The general idea is that users can search for food products and see nearby stores with matching or similar community-submitted deals. Users can also submit deals they find and help confirm whether existing deals are still valid.

The project is still in the prototyping phase. Avoid introducing unnecessary abstractions, fixed assumptions, or architecture that would make experimentation difficult.

## Current Stack

The expected stack is:

* Flutter for the mobile application
* NestJS for the backend API
* PostgreSQL for persistent data
* Prisma as the ORM and database migration tool
* Docker for local development and deployment
* Cloud hosting for the backend and database
* Object storage for uploaded images

The exact cloud provider and storage provider are intentionally undecided.

## Main Domain Concepts

The system currently revolves around the following concepts:

### Users

Users are authenticated accounts that interact with the application.

The mobile application does not need user registration or general user CRUD.

User accounts may be created and managed through an administrative interface.

Users may:

* authenticate
* search for products and deals
* submit deals
* confirm or reject existing deals

Administrators may have additional management capabilities.

### Products

Products represent searchable food items.

Products may contain information such as:

* name
* brand
* category
* aliases or search terms

Product similarity should initially remain simple. Categories, aliases, and text matching are preferred over introducing AI or recommendation systems unless they become necessary.

### Stores

Stores represent physical locations where deals can be found.

A store may contain:

* name
* address
* geographic coordinates

Store coordinates can be used to determine how close a deal is to a user.

### Deals

Deals represent a product being offered at a specific store for a specific price.

A deal may contain information such as:

* product
* store
* price
* original price
* description
* submitting user
* creation time
* expiration time
* optional image

Expired or invalid deals should normally not appear in active search results.

### Deal Feedback

Users may confirm whether a deal is still available or indicate that it is no longer valid.

The exact scoring or verification system is not finalized.

Avoid hardcoding a specific confidence algorithm unless required.

## Images

Image binary data should not be stored directly in PostgreSQL.

Images should be stored using an external object or file storage service.

PostgreSQL should store only the relevant image identifier, path, or URL.

The storage provider is intentionally unspecified while the application is being prototyped.

The intended upload flow is approximately:

Flutter application -> NestJS backend -> object storage -> PostgreSQL reference

The backend should validate uploads before storing them.

## Authentication

Authentication is expected to be handled by the NestJS backend.

A token-based approach such as JWT is appropriate.

The backend should determine the authenticated user from authentication information rather than trusting user identifiers supplied by the client.

For example, when creating a deal, the submitting user should be derived from the authenticated request rather than from a client-provided `userId`.

## Backend Architecture

NestJS modules should generally be organized around application domains.

Possible modules include:

* authentication
* users
* products
* stores
* deals
* deal feedback
* search
* administration
* Prisma/database integration

This list is not a strict requirement. Modules may be reorganized as the project evolves.

Prefer the usual NestJS separation:

Controller -> Service -> Prisma -> PostgreSQL

Controllers should primarily handle HTTP concerns.

Services should contain application and business logic.

Prisma should handle persistence and database access.

## Prisma and PostgreSQL

Prisma is the primary database access layer.

The Prisma schema should represent relationships between the application's domain entities.

Database schema changes should be performed using Prisma migrations.

Avoid designing the entire final schema upfront. Add fields and relationships as requirements become clearer.

Seed data may be used during development so the application can be demonstrated without manually populating the database.

## Search

Search should allow users to look for products and discover relevant nearby deals.

The general flow is:

1. Receive a product search query.
2. Find matching or related products.
3. Find active deals associated with those products.
4. Determine the location of the associated stores.
5. Filter or order results using location and relevance.
6. Return the results to the mobile application.

The exact ranking algorithm is intentionally unspecified.

Start with simple text matching, aliases, categories, distance, and deal freshness.

## Location

The mobile application may provide the user's current coordinates when requesting nearby results.

Stores should have enough geographic information to calculate distance.

A simple latitude/longitude solution is sufficient during early development.

More advanced PostgreSQL geospatial functionality such as PostGIS may be considered later if needed.

Do not introduce it prematurely.

## Admin Interface

A basic administrative interface is expected.

It may be used for tasks such as:

* creating and managing users
* managing stores
* managing products
* moderating deals
* disabling inappropriate or invalid content

The exact capabilities of the admin interface are still subject to change.

## Docker

Docker should be used to make development and deployment reproducible.

During local development, Docker may run services such as:

* NestJS
* PostgreSQL

In a cloud environment, the backend may remain containerized while PostgreSQL and object storage may be provided through managed services.

Do not assume a specific cloud vendor in application code.

Configuration that changes between environments should come from environment variables.

## Configuration

Do not hardcode:

* database credentials
* API URLs
* cloud provider URLs
* storage credentials
* JWT secrets
* ports that may vary between environments
* production domain names
* geographic assumptions
* fixed store or product data

Use environment variables and configuration modules where appropriate.

Keep environment-specific configuration outside the main application logic.

## Development Principles

Because the project is still being prototyped:

* Prefer simple implementations.
* Avoid premature optimization.
* Avoid unnecessary abstractions.
* Do not commit to a cloud vendor unless required.
* Keep modules reasonably independent.
* Validate external input.
* Keep business logic outside controllers.
* Use Prisma migrations for database changes.
* Keep secrets out of the repository.
* Do not trust client-provided ownership or user identity information.
* Prefer code that is easy to replace as requirements evolve.

The goal is to build a functional prototype while keeping the architecture flexible enough to change as the assignment becomes more clearly defined.

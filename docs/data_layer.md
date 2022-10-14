
![Architecture Overview](images/architecture_overview.png)

# Data Layer

The Data Layer is an abstraction layer to encapsulate data coming from concrete sources, such as databases, network requests, third-party services, etc. Within the data layer, we have Data Providers and Repositories.

Ideally, the Data Layer is not meant to be tied to a single mobile app. However, it can start there and then get pulled out when there is a second use-case.

## Data Provider

Data Providers will wrap concrete databases, network requests etc, and is the lowest-level in our abstraction hierarchy.

## Repository

Repositories will wrap _1 or more_ Data Providers and will be used to communicate to Blocs and Cubits.

_Note: We have made a design choice where application state is **not** held in repositories. All application state will be held in Blocs or Cubits._

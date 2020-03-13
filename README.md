
# UNogsAPI

  

[![Build Status](https://travis-ci.org/murphb52/UNogsAPIClient.svg?branch=master)](https://travis-ci.org/murphb52/UNogsAPIClient)  [![codecov](https://codecov.io/gh/murphb52/UNogsAPIClient/branch/master/graph/badge.svg)](https://codecov.io/gh/murphb52/UNogsAPIClient)

  

Swift Package to help connect easily to the UNogsAPI using Combine publishers

  

## Installation

  

### Swift Package Manager

  

This is currently purely available as a Swift Package and can be integrated using the SPM

## Use

### UNogsAPIClient

The `UnogsAPIClient` object is the hub of the package. It will require a valid API Key that can be retrieved from [https://rapidapi.com/unogs/api/unogs](https://rapidapi.com/unogs/api/unogs).

### Currently Supported information 
- Fetch list of **countries**
- Fetch list of **genres**
- Fetch list of **expiring titles**
- Fetch list of **new titles**
- **Search** for titles

### Upcoming Improvements
- Pagination

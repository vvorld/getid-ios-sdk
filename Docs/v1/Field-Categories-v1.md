# Field categories

All the text data about the user represented as FormField objects. See [this section](README-v1.md#form-screen-setup) of the main Readme file. To standardize the fields' names, we assign them "categories" based on their titles. 

| Category | Titles |
| ----- | ----- |
| `.firstName` | "first name", "name", "given names" |
| `.lastName` | "last name", "surname", "family name", "second name" |
| `.email` | "email", "e-mail" |
| `.dateOfBirth` | "date of birth", "birth date", "birthdate", "dob" |
| `.address` | "address", "home address", "delivery address" |
| `.birthPlace` | "birth place", "place of birth" |
| `.nationality` | "nationality", "citizenship" |
| `.personalNumber` | "personal number", "personal code" |
| `.sex` | "sex", "gender" |
| `.dateOfExpiry` | "date of expiry", "expiration date" |
| `.documentNumber` | "document number", "number of document" |
| `.issuingCountry` | "issuing country" |

Note: the case of the title does not matter. For example, both "First Name" and "First name" go to `.firstName` category.

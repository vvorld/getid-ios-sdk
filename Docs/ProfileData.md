# Profile data

We call "profile data" the information that users provide about themselves. Such information can be captured at the "Profile Data" step of the GetID verification flow. Also, you can pass such info to GetID SDK if it's available before starting the GetID verification flow. 

If the verification flow contains the "Profile Data" step, then the "profile data" can be used to prefill the form. The user then can confirm that the data is correct, or edit it.

If the verification flow does not contain the "Profile Data" step, then the "profile data" will be sent to the GetID server as is (if it's in the valid format, see the details below).

### Content types

The profile data consists of individual "fields". The fields' values can be of four types: `string`, `country`, `date`, and `gender`. We call it "content types". See the valid format for each type in the table below.

| Content type | Format | Example |
| ----- | ----- | ----- |
| `string` | An arbitrary string | `"Alex"` |
| `country` | ISO 3166-1 alpha-3 country code | `"EST"` |
| `date` | `yyyy-MM-dd` | `"1988-10-27"` |
| `gender` | `male` or `female` | `"female"` |

### Predefined fields

There are "predefined" fields and "custom" fields. Predefined fields are the fields that you can add to the "Profile Data" step while configuring a flow in the GetID admin panel. Their titles are localized and we have validations in our SDK for such fields: for example, if a user enters an invalid email address, the SDK will ask to re-enter it.

Each predefined field belongs to a particular "category". You can see these categories on an application details page in the admin panel. The categories are field titles in the table with the applicant's profile data.

See the list of the predefined fields in the table below.

| Field type | Content type | Category |
| ----- | ----- | ----- |
| `first-name` | `string` | `First name` |
| `last-name` | `string` | `Last name` |
| `email` | `string` | `Email` |
| `phone-number` | `string` | `Phone number` |
| `address` | `string` | `Address` |
| `personal-number` | `string` | `Personal number` |
| `document-number` | `string` | `Document number` |
| `city-of-residence` | `string` | `City of residence` |
| `country-of-residence` | `country` | `Country of residence` |
| `nationality` | `country` | `Nationality` |
| `gender` | `gender` | `Gender` |
| `date-of-birth` | `date` | `Date of birth` |
| `date-of-issue` | `date` | `Date of issue` |
| `date-of-expiry` | `date` | `Date of expiry` |
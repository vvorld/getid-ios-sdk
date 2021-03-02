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

### Fields creation

One can create `GetIDProfileData` passing a `[String: String]` dictionary to its initializer. 

If a key matches a `Field type` or a `Category` from the table above and its value is valid then a predefined field will be created. If a key matches a `Field type` or a `Category`, but its value is not valid then this key-value pair will be skipped. 

If a key does not match any `Field type` and `Category` then a "custom" field will be created, with `string` content type. "Custom" fields can not be displayed in the "Profile Data" step of the verification flow so can't be edited by users.

### Example

```swift
let profileData = GetIDProfileData(
    ["first-name": "John", // valid, matches to a field type
     "Last name": "Johnson", // also valid, matches to a category
     "date-of-birth": "1985-10-21", // valid
     "document-number": "0000000", // valid
     "Nationality": "EST", // valid
     "Country of residence": "Russia", // NOT valid, should be RUS
     "date-of-expiry": "10.10.2025", // NOT valid, should be 2025-10-10
     "gender": "male"] // valid
)
GetIDSDK.startVerificationFlow(
  apiUrl: "API_URL",
  auth: .jwt("JWT"),
  flowName: "flow-1",
  profileData: profileData
)
```
If there is no "Profile Data" step in the selected flow (`flow-1`), then the following fields will be sent to the GetID server, without the user's edit: `First name`, `Last name`, `Date of birth`, `Document number`, `Nationality`, `Gender`.

If the flow (`flow-1`) contains "Profile Data" step and `First name` and `Last name` fields are enabled, then these two fields will be prefilled with `"John"` and `"Johnson"` values. The user will be able to edit them. The other four fields won't be displayed to the user but will be sent to the GetID server too.
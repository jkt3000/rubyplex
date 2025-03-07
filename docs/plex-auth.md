# Auth / Login

Here are the key steps for how the `/pins` API endpoint works to obtain a Plex token and server URL:

1. Generate a PIN Code

```
curl -X POST "https://plex.tv/api/v2/pins" \
-H "X-Plex-Client-Identifier: my-unique-app-id" \
-H "Accept: application/json"
```
```json
{
  "id": 12345678,
  "code": "ABCD",
  "clientIdentifier": "my-unique-app-id",
  "expiresAt": "2025-03-07T05:39:00Z"
}
```

2. User Links the PIN

Action: The user must manually visit https://plex.tv/link in a web browser, sign into their Plex account, and enter the 4-character PIN code (e.g., "ABCD") provided in the previous step.
Result: Once the user submits the PIN, Plex associates the clientIdentifier with their account and generates an authentication token. This step must be completed before the PIN expires.

3. Poll for the Authentication Token

```
Endpoint: GET https://plex.tv/api/v2/pins/{pin_id}
```

Action: Repeatedly poll the /pins/{pin_id} endpoint (where {pin_id} is the id from Step 1) to check if the user has linked the PIN and to retrieve the token.
Headers: Include the same headers as in Step 1:
X-Plex-Client-Identifier: Must match the identifier used in the initial request.
Accept: Set to application/json.
Polling: Keep sending GET requests (e.g., every few seconds) until the response includes an authToken.
Response: Initially, the response will show the PIN’s status as pending (no authToken). Once the user links the PIN:
authToken: A string representing the Plex token will be included.
expiresAt: Updated expiration details for the token.

```
curl -X GET "https://plex.tv/api/v2/pins/12345678" \
-H "X-Plex-Client-Identifier: my-unique-app-id" \
-H "Accept: application/json"
```

response with auth token
```json
{
  "id": 12345678,
  "code": "ABCD",
  "clientIdentifier": "my-unique-app-id",
  "authToken": "xXxXxxxxXxXxXxXx",
  "expiresAt": "2025-03-07T05:39:00Z"
}
```

4. Retrieve Server URL Using the Token

```
Endpoint: GET https://plex.tv/api/v2/resources?includeHttps=1
```

Action: Use the authToken obtained in Step 3 to query the /resources endpoint, which lists all servers associated with the user’s Plex account.
Headers:
X-Plex-Token: Set to the authToken from Step 3.
X-Plex-Client-Identifier: The same identifier used previously.
Accept: Set to application/json.
Response: Returns a JSON array of resources, including Plex Media Servers. Each server entry includes:
name: The server’s friendly name.
connections: An array of connection details (e.g., local and remote URLs).
address and port: Components of the server URL.
uri: The full server URL (e.g., http://192.168.1.100:32400 or a remote plex.direct URL).


```
curl -X GET "https://plex.tv/api/v2/resources?includeHttps=1" \
-H "X-Plex-Token: xXxXxxxxXxXxXxXx" \
-H "X-Plex-Client-Identifier: my-unique-app-id" \
-H "Accept: application/json"

[
  {
    "name": "My Plex Server",
    "clientIdentifier": "server-uuid",
    "provides": "server",
    "connections": [
      {
        "protocol": "http",
        "address": "192.168.1.100",
        "port": 32400,
        "uri": "http://192.168.1.100:32400",
        "local": true
      },
      {
        "protocol": "https",
        "address": "plex.direct",
        "port": 32400,
        "uri": "https://123-456-789-123.plex.direct:32400",
        "local": false
      }
    ]
  }
]
```

Be sure to get the uri that is locally accesible

5. Use the Token and Server URL

Plex Token: The authToken can now be used as the X-Plex-Token in requests to the Plex Media Server API (e.g., http://192.168.1.100:32400/library/sections?X-Plex-Token=xXxXxxxxXxXxXxXx).
Server URL: The uri from the /resources response is the base URL for interacting with the server (e.g., to fetch library data or control playback).
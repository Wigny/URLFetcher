# URLFetcher

Requirements:

To run the application in the correct version of Elixir and Phoenix, you need to have [`Docker`](https://docs.docker.com/get-started/) and [`Visual Studio Code`](https://code.visualstudio.com/docs/) installed locally.

### Preparing the environment:

  * With Visual Studio Code open, install the extension [`Remote - Containers`](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) from the marketplace ( <kbd>Ctrl/Cmd</kbd> + <kbd>Shift</kbd> + <kbd>X</kbd>).
  * Reopen the project inside the Dev Container by typing <kbd>Ctrl/Cmd</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> and selecting `Remote-Containers: Reopen in Container`

### Starting the application:

  * The Dev Container should itself perform the installation of all dependencies, if that doesn't happen correctly, just run `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server`

### Using the application:

The application will be available at [`localhost:4000`](http://localhost:4000).

It is now possible to fetch web pages in the browser from [`localhost:4000/api/fetch/?url=https://example.com`](http://localhost:4000/api/fetch/?url=https://example.com) or from command line tools such as cURL by running:

```bash
curl --location --request GET 'http://localhost:4000/api/fetch/?url=https://example.com'
```

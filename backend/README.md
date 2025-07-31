
<p align="center">
  <a href="http://nestjs.com/" target="blank"><img src="https://nestjs.com/img/logo-small.svg" width="120" alt="Nest Logo" /></a>
</p>

# Overview

This backend powers a certificate verification system. It enables organizations to securely issue certificates for students, ensuring authenticity and preventing forgery. Organizations can obtain API keys to manage certificates, including issuing, modifying, revoking, and verifying them through API endpoints.

## Main features:
- API key management for organizations
- Certificate issuance and modification
- Certificate revocation
- Certificate verification


## How to use API Documentation

<details open>
<summary>📚 <strong>Quickstart</strong> - Basic Usage</summary>

1. **Open the `openapi.yaml` file in an online viewer**  
    Visit [Swagger Editor](https://editor.swagger.io/) or a similar website.

2. **Upload or paste the `openapi.yaml` content**  
    Use the website interface to load your `openapi.yaml` file.

3. **Browse the API documentation**  
    The website will render interactive API docs. Explore available endpoints, parameters, request/response formats, and authentication requirements directly in your browser.

4. **Refer to examples and schemas**  
    Review example requests/responses and **schema** definitions provided in the rendered documentation.

</details>

<details>
<summary>🔥 <strong>Developer Guide:</strong> - Testing & Development</summary>

1. **Install an OpenAPI extension in VS Code**  
    Search for and install the [VSCode OpenAPI Viewer](https://marketplace.visualstudio.com/items?itemName=AndrewButson.vscode-openapi-viewer) (Recommended) extension from the Extensions Marketplace.

2. **Open the `openapi.yaml` file in VS Code**  
    Navigate to your project folder and open the `openapi.yaml` file.

3. **Preview the API documentation**  
    Look for the **OpenAPI** button (extension logo) in the top right corner of the file tab (next to the Run Code ▶️ button). Click it to open the interactive API documentation preview within VS Code.

4. **Explore endpoints and schemas**  
    The extension will render interactive API documentation directly in VS Code. Browse endpoints, parameters, request/response formats, and authentication details.

5. **Refer to examples and try out requests**  
    Some extensions allow you to try out API requests or view example and payloads schemas directly within the editor.
</details>

## Project setup

```bash
$ npm install
```

## Compile and run the project

```bash
# development
$ npm run start

# watch mode
$ npm run start:dev

# production mode
$ npm run start:prod
```

## Run tests

```bash
# unit tests
$ npm run test

# e2e tests
$ npm run test:e2e

# test coverage
$ npm run test:cov
```

## Deployment

When you're ready to deploy your NestJS application to production, there are some key steps you can take to ensure it runs as efficiently as possible. Check out the [deployment documentation](https://docs.nestjs.com/deployment) for more information.

If you are looking for a cloud-based platform to deploy your NestJS application, check out [Mau](https://mau.nestjs.com), our official platform for deploying NestJS applications on AWS. Mau makes deployment straightforward and fast, requiring just a few simple steps:

```bash
$ npm install -g @nestjs/mau
$ mau deploy
```

With Mau, you can deploy your application in just a few clicks, allowing you to focus on building features rather than managing infrastructure.

## Resources

Check out a few resources that may come in handy when working with NestJS:

- Visit the [NestJS Documentation](https://docs.nestjs.com) to learn more about the framework.
- For questions and support, please visit our [Discord channel](https://discord.gg/G7Qnnhy).
- To dive deeper and get more hands-on experience, check out our official video [courses](https://courses.nestjs.com/).
- Deploy your application to AWS with the help of [NestJS Mau](https://mau.nestjs.com) in just a few clicks.
- Visualize your application graph and interact with the NestJS application in real-time using [NestJS Devtools](https://devtools.nestjs.com).
- Need help with your project (part-time to full-time)? Check out our official [enterprise support](https://enterprise.nestjs.com).
- To stay in the loop and get updates, follow us on [X](https://x.com/nestframework) and [LinkedIn](https://linkedin.com/company/nestjs).
- Looking for a job, or have a job to offer? Check out our official [Jobs board](https://jobs.nestjs.com).

## Support

Nest is an MIT-licensed open source project. It can grow thanks to the sponsors and support by the amazing backers. If you'd like to join them, please [read more here](https://docs.nestjs.com/support).

## Stay in touch

- Author - [Kamil Myśliwiec](https://twitter.com/kammysliwiec)
- Website - [https://nestjs.com](https://nestjs.com/)
- Twitter - [@nestframework](https://twitter.com/nestframework)

## License

Nest is [MIT licensed](https://github.com/nestjs/nest/blob/master/LICENSE).

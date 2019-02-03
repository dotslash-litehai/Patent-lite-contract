# Patent-lite-contract

This contract is deployed on Azure Blockchain Workbench.


## What is Azure Blockchain Workbench?
Azure Blockchain Workbench simplifies consortium blockchain network setup as a preconfigured solution with an Azure Resource Manager solution template. The template provides simplified deployment that deploys all components needed to run a consortium. Today, Blockchain Workbench currently supports <b> Ethereum</b>.

Azure Blockchain Workbench provides a web application and REST APIs for managing blockchain applications and users. Blockchain Workbench administrators can <b>manage application access</b> and assign your users to application roles. Azure AD users are automatically mapped to members in the application.

Configuration file - <code>Patent.json</code>:

Configuration metadata defines the high-level workflows and interaction model of the blockchain application. Configuration metadata represents the workflow stages and interaction model of the blockchain application.

Solidity Contract - <code>Patent1.sol</code>:

Smart contracts represent the business logic of the blockchain application. Currently, Blockchain Workbench supports Ethereum for the blockchain ledger. Ethereum uses Solidity as its programming language for writing self-enforcing business logic for smart contracts.

### Workflow of Contract:

<img src="./flowchart.jpg">


# IslamXplorer

IslamXplorer is a powerful, modern search engine designed to explore the Quran and Hadith. Leveraging knowledge graphs, IslamXplorer enables users to discover relationships and connections between concepts within the Quran and Hadith, making learning and understanding Islamic texts more intuitive and insightful.

## Features

- **Advanced Search Engine**: Use knowledge graphs to explore relationships between concepts in the Quran and Hadith.
- **React Web Application**: Fast and responsive web interface for searching and browsing.
- **Flutter Mobile App**: A seamless mobile experience for searching Islamic texts on the go.
- **Python API**: Provides endpoints to fetch data and manage the knowledge graph.
- **Neo4j Knowledge Graph**: Stores and analyzes the relationships between various concepts and topics.
- **MongoDB**: Acts as the primary database for storing user and additional metadata.

## Tech Stack

| Technology       | Description                                            |
|------------------|--------------------------------------------------------|
| **React**        | Web interface for searching and browsing.              |
| **Flutter**      | Mobile application for iOS and Android platforms.      |
| **Python**       | API backend for handling search requests and queries.  |
| **Neo4j**        | Knowledge graph for linking and querying Quranic and Hadith data. |
| **MongoDB**      | Stores user data, authentication, and metadata.        |
| **Firebase**     | Manages authentication and user data syncing.          |

## Architecture

1. **Web and Mobile Interface**:
   - The **React Web App** and **Flutter Mobile App** provide an intuitive user interface for users to interact with the search engine.
   - Users can search for Quranic verses, Hadith, and related topics.

2. **Backend API**:
   - A **Python Flask API** serves as the backend, responsible for processing search queries, interfacing with the knowledge graph, and delivering results to the frontend.

3. **Knowledge Graph**:
   - Powered by **Neo4j**, the knowledge graph stores and manages the relationships between various concepts, such as Quranic themes, keywords, and Hadith references. This enables complex search queries and contextual results.

4. **Database**:
   - **MongoDB** acts as the primary database for storing user profiles, search history, preferences, and related metadata.

## Getting Started

### Prerequisites

- **Node.js** (for React app)
- **Flutter** (for mobile app)
- **Python** (for API)
- **Neo4j** (for knowledge graph)
- **MongoDB** (for database)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/username/IslamXplorer.git
   cd IslamXplorer

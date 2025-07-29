---
created: 2025-04-18 05:31:26
author: N/A
version: N/A
license(s): N/A
copyright: N/A
---

----


# Swift CoreML Transformers

---

<div align="center">
  <blockquote>
  As a visual learner student, I created these personal study notes from the cited source(s) to aid my understanding.<br/>
  While my firm intention is to provide full credit, the blended format of notes and diagrams may sometimes obscure the original source, for which I apologize.<br/>
  I am committed to making corrections and welcome any feedback.<br/>
  This is a non-commercial project for my humble educational purposes only since the start.<br/>
  My goal is to share my perspective and contribute to the great work already being done.
  <br/>
  <br/>
  I want to extend my genuine apologies to the creators of the original material.<br/>
  Their work was the direct inspiration for this project, and I adapted it without first reaching out.<br/>
  My intent comes from a place of deep respect, and I hope this is received in the spirit of homage.<br/>
  🙏🏼🙏🏼🙏🏼🙏🏼
  </blockquote>
</div>

----


```mermaid
---
title: "Swift CoreML Transformers"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  layout: elk
  look: handDrawn
  theme: dark
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Toggle theme value to `base` to activate the initilization below for the customized theme version.
%%%%%%%% Available curve styles include the following keywords:
%% basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    'flowchart': {'htmlLabels': true, 'curve': 'step' },
    'fontFamily': 'Monospace',
    'themeVariables': {
      'lineColor': '#F8B229'
    }
  }
}%%
flowchart TD
    %% iOS App Frontends
    subgraph CoreMLBert_App["CoreMLBert App"]
        direction TB
        BAppDelegate["AppDelegate.swift"]:::frontend
        BSceneDelegate["SceneDelegate.swift"]:::frontend
        BViewController["ViewController.swift"]:::frontend
        BLoaderView["LoaderView.swift"]:::frontend
        BLaunchStoryboard["LaunchScreen.storyboard"]:::frontend
        BMainStoryboard["Main.storyboard"]:::frontend
        BAssets["Assets.xcassets"]:::frontend
    end

    subgraph CoreMLGPT2_App["CoreMLGPT2 App"]
        direction TB
        GAppDelegate["AppDelegate.swift"]:::frontend
        GSceneDelegate["SceneDelegate.swift"]:::frontend
        GViewController["ViewController.swift"]:::frontend
        GLaunchStoryboard["LaunchScreen.storyboard"]:::frontend
        GMainStoryboard["Main.storyboard"]:::frontend
        GAssets["Assets.xcassets"]:::frontend
    end

    %% Shared Transformer Core Library
    subgraph Transformer_Core_Library["Transformer Core Library"]
        direction TB
        BertTokenizer["BertTokenizer.swift"]:::library
        BertQA["BertForQuestionAnswering.swift"]:::library
        GPT2Tokenizer["GPT2Tokenizer.swift"]:::library
        GPT2Model["GPT2.swift"]:::library
        GPT2Encoder["GPT2ByteEncoder.swift"]:::library
        MultiArrayUtils["MLMultiArray+Utils.swift"]:::library
        MathUtils["Math.swift"]:::library
        SquadDataset["SquadDataset.swift"]:::library
        Utils["Utils.swift"]:::library
    end

    %% Static Resources
    subgraph Resources["Resources"]
        direction TB
        Models["*.mlmodel"]:::resources
        VocabFiles["vocab & merge files"]:::resources
        SampleJSON["sample JSON files"]:::resources
    end

    %% Offline Conversion Pipeline
    subgraph Offline_Model_Generation["Offline Model Generation"]
        direction TB
        Gpt2Py["gpt2.py"]:::offline
        DistilOnnx["distilbert-onnx-coreml.py"]:::offline
        DistilValidate["distilbert-validate.py"]:::offline
        PerformanceDoc["distilbert-performance.md"]:::offline
        UtilsPy["utils.py"]:::offline
        Requirements["requirements.txt"]:::offline
    end

    %% Test Suites
    subgraph Unit_Tests["Unit Tests"]
        direction TB
        subgraph CoreMLBertTests["CoreMLBertTests"]
            direction TB
            BTokTests["BertTokenizerTests.swift"]:::tests
            BQATests["BertForQATests.swift"]:::tests
            BDQATests["DistilbertForQATests.swift"]:::tests
        end
        subgraph CoreMLGPT2Tests["CoreMLGPT2Tests"]
            direction TB
            GPT2Tests["CoreMLGPT2Tests.swift"]:::tests
            MAUtilsTests["MultiArrayUtilsTests.swift"]:::tests
        end
    end

    %% Runtime Inference Flow
    BViewController -->|"user input"| BertTokenizer
    GViewController -->|"user input"| GPT2Tokenizer
    BertTokenizer -->|"token IDs"| MultiArrayUtils
    GPT2Tokenizer -->|"token IDs"| MultiArrayUtils
    MultiArrayUtils -->|"MLMultiArray"| Models
    Models -->|"MLMultiArray output"| BertQA
    Models -->|"MLMultiArray output"| GPT2Model
    BertQA -->|"decoded text"| BViewController
    GPT2Model -->|"decoded text"| GViewController

    %% Shared Library Usage
    BViewController -->|"calls"| Utils
    GViewController -->|"calls"| Utils
    SquadDataset -->|"data load"| BertQA

    %% Offline Pipeline
    Gpt2Py -->|"convert to .mlmodel"| Models
    DistilOnnx -->|"convert to .mlmodel"| Models
    DistilValidate -->|"validate"| Models

    %% Tests
    BTokTests -->|"tests"| BertTokenizer
    BQATests -->|"tests"| BertQA
    BDQATests -->|"tests"| BertQA
    GPT2Tests -->|"tests"| GPT2Model
    MAUtilsTests -->|"tests"| MultiArrayUtils

    %% Click events
    click BAppDelegate "https://github.com/huggingface/swift-coreml-transformers/blob/master/CoreMLBert/AppDelegate.swift"
    click BSceneDelegate "https://github.com/huggingface/swift-coreml-transformers/blob/master/CoreMLBert/SceneDelegate.swift"
    click BViewController "https://github.com/huggingface/swift-coreml-transformers/blob/master/CoreMLBert/ViewController.swift"
    click BLoaderView "https://github.com/huggingface/swift-coreml-transformers/blob/master/CoreMLBert/LoaderView.swift"
    click BLaunchStoryboard "https://github.com/huggingface/swift-coreml-transformers/blob/master/CoreMLBert/Base.lproj/LaunchScreen.storyboard"
    click BMainStoryboard "https://github.com/huggingface/swift-coreml-transformers/blob/master/CoreMLBert/Base.lproj/Main.storyboard"
    click BAssets "https://github.com/huggingface/swift-coreml-transformers/blob/master/CoreMLBert/Assets.xcassets"

    click GAppDelegate "https://github.com/huggingface/swift-coreml-transformers/blob/master/CoreMLGPT2/AppDelegate.swift"
    click GSceneDelegate "https://github.com/huggingface/swift-coreml-transformers/blob/master/CoreMLGPT2/SceneDelegate.swift"
    click GViewController "https://github.com/huggingface/swift-coreml-transformers/blob/master/CoreMLGPT2/ViewController.swift"
    click GLaunchStoryboard "https://github.com/huggingface/swift-coreml-transformers/blob/master/CoreMLGPT2/Base.lproj/LaunchScreen.storyboard"
    click GMainStoryboard "https://github.com/huggingface/swift-coreml-transformers/blob/master/CoreMLGPT2/Base.lproj/Main.storyboard"
    click GAssets "https://github.com/huggingface/swift-coreml-transformers/blob/master/CoreMLGPT2/Assets.xcassets"

    click BertTokenizer "https://github.com/huggingface/swift-coreml-transformers/blob/master/Sources/BertTokenizer.swift"
    click BertQA "https://github.com/huggingface/swift-coreml-transformers/blob/master/Sources/BertForQuestionAnswering.swift"
    click GPT2Tokenizer "https://github.com/huggingface/swift-coreml-transformers/blob/master/Sources/GPT2Tokenizer.swift"
    click GPT2Model "https://github.com/huggingface/swift-coreml-transformers/blob/master/Sources/GPT2.swift"
    click GPT2Encoder "https://github.com/huggingface/swift-coreml-transformers/blob/master/Sources/GPT2ByteEncoder.swift"
    click MultiArrayUtils "https://github.com/huggingface/swift-coreml-transformers/blob/master/Sources/MLMultiArray+Utils.swift"
    click MathUtils "https://github.com/huggingface/swift-coreml-transformers/blob/master/Sources/Math.swift"
    click SquadDataset "https://github.com/huggingface/swift-coreml-transformers/blob/master/Sources/SquadDataset.swift"
    click Utils "https://github.com/huggingface/swift-coreml-transformers/blob/master/Sources/Utils.swift"

    click Models "https://github.com/huggingface/swift-coreml-transformers/tree/master/Resources/"
    click VocabFiles "https://github.com/huggingface/swift-coreml-transformers/tree/master/Resources/"
    click SampleJSON "https://github.com/huggingface/swift-coreml-transformers/tree/master/Resources/"

    click Gpt2Py "https://github.com/huggingface/swift-coreml-transformers/blob/master/model_generation/gpt2.py"
    click DistilOnnx "https://github.com/huggingface/swift-coreml-transformers/blob/master/model_generation/distilbert-onnx-coreml.py"
    click DistilValidate "https://github.com/huggingface/swift-coreml-transformers/blob/master/model_generation/distilbert-validate.py"
    click PerformanceDoc "https://github.com/huggingface/swift-coreml-transformers/blob/master/model_generation/distilbert-performance.md"
    click UtilsPy "https://github.com/huggingface/swift-coreml-transformers/blob/master/model_generation/utils.py"
    click Requirements "https://github.com/huggingface/swift-coreml-transformers/blob/master/model_generation/requirements.txt"

    click BTokTests "https://github.com/huggingface/swift-coreml-transformers/blob/master/CoreMLBertTests/BertTokenizerTests.swift"
    click BQATests "https://github.com/huggingface/swift-coreml-transformers/blob/master/CoreMLBertTests/BertForQATests.swift"
    click BDQATests "https://github.com/huggingface/swift-coreml-transformers/blob/master/CoreMLBertTests/DistilbertForQATests.swift"
    click GPT2Tests "https://github.com/huggingface/swift-coreml-transformers/blob/master/CoreMLGPT2Tests/CoreMLGPT2Tests.swift"
    click MAUtilsTests "https://github.com/huggingface/swift-coreml-transformers/blob/master/CoreMLGPT2Tests/MultiArrayUtilsTests.swift"

    %% Styles
    classDef frontend fill:#cce5ff,stroke:#004085,color:#004085
    classDef library fill:#d4edda,stroke:#155724,color:#155724
    classDef resources fill:#fff3cd,stroke:#856404,color:#856404,stroke-dasharray: 5 5
    classDef offline fill:#e2e3e5,stroke:#6c757d,color:#6c757d
    classDef tests fill:#f8d7da,stroke:#721c24,color:#721c24

```


---

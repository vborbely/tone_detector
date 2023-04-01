
This package is a Tone Detection library for Flutter.
It can detect the tone of the text using Chat GPT API.

## Features

* Detect the tone of the text and return an analysis score.
* Supported analysis:
  * Aggressivity : range from 0.0 to 1.0, where 1.0 is extremly aggressive.

## Getting started

1. Request a secure API key for the endpoint at viktor [at] uira-tervezve.hu address.
2. Add the package to your pubspec.yaml file:

```yaml 
dependencies:
  tone_detection: ^0.0.2
```

## Usage

1. Create a ToneDetectorController
2. Use the ToneDetectorWidget, give the controller as a parameter

```
void main() {
  TD.configure(apiKey: toneDetectorServiceKey ?? '');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tone Detector Example',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey.shade200,
        primarySwatch: Colors.yellow,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.white),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  final ToneDetectorController controller = ToneDetectorController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat :: Tone Detector'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => controller.analyze('I am angry', aggressiveness: 0.4),
              child: const Text('Analyze'),
            ),
            ToneDetectorWidget(
              controller: controller,
            ),
          ],
        ),
      ),
    );
  }
}
```

## Additional information

I plan to add more analysis in the future, like:

- Sentiment
- Friendliness
- Formality

Also, visualizing the tone of the text is a good idea.
Right now, a very simple BarChart is used to visualize the tone.

Any suggestions and contributions are welcomed!

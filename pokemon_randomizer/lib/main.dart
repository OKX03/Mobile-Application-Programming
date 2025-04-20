import 'dart:math';
import 'package:flutter/material.dart';
import 'pokemon_data.dart';

void main() {
  runApp(const PokemonApp());
}

class PokemonApp extends StatelessWidget {
  const PokemonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokémon Randomizer',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? currentIndex;

  void getRandomPokemon() {
    final random = Random();
    currentIndex = random.nextInt(gen1Pokemon.length);
    setState(() {});
  }

  void evolvePokemon() {
    if (currentIndex == null) return;
    final current = gen1Pokemon[currentIndex!];
    final evolutionLine = current["evolutionLine"] as List<String>;
    final stage = current["stage"] as int;

    if (stage < evolutionLine.length - 1) {
      final nextName = evolutionLine[stage + 1];
      final nextIndex =
          gen1Pokemon.indexWhere((p) => p["name"] == nextName);
      if (nextIndex != -1) {
        currentIndex = nextIndex;
        setState(() {});
      }
    }
  }

  void devolvePokemon() {
    if (currentIndex == null) return;
    final current = gen1Pokemon[currentIndex!];
    final evolutionLine = current["evolutionLine"] as List<String>;
    final stage = current["stage"] as int;

    if (stage > 0) {
      final prevName = evolutionLine[stage - 1];
      final prevIndex =
          gen1Pokemon.indexWhere((p) => p["name"] == prevName);
      if (prevIndex != -1) {
        currentIndex = prevIndex;
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/pokemon_ball.jpg"), 
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          TitleSection(title: "Pokémon Randomizer Game"),
          Expanded(
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/background.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: currentIndex != null
                    ? PokemonDisplayCard(
                        name: gen1Pokemon[currentIndex!]["name"],
                        imageUrl: gen1Pokemon[currentIndex!]["image"],
                      )
                    : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Image(
                          image: AssetImage("images/guess_pokemon1.PNG"),
                          width: 100, // Optional size
                        ),
                        SizedBox(height: 12),
                        Text(
                          "🎯 Ready to get a random Pokémon?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromARGB(255, 136, 1, 1),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
              ),
            ),
          ),

          Expanded(
            flex: 2,
            child: Container(
              color: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ActionButtons(
                    onDevolve: devolvePokemon,
                    onEvolve: evolvePokemon,
                  ),
                  RandomButton(onPressed: getRandomPokemon),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PokemonDisplayCard extends StatelessWidget {
  final String name;
  final String imageUrl;

  const PokemonDisplayCard({
    super.key,
    required this.name,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(imageUrl, height: 200),
            const SizedBox(height: 10),
            Text(
              name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActionButtons extends StatelessWidget {
  final VoidCallback onDevolve;
  final VoidCallback onEvolve;

  const ActionButtons({
    super.key,
    required this.onDevolve,
    required this.onEvolve,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: onDevolve,
          icon: const Icon(Icons.arrow_back),
          label: const Text("Devolve"),
        ),
        ElevatedButton.icon(
          onPressed: onEvolve,
          icon: const Icon(Icons.arrow_forward),
          label: const Text("Evolve"),
        ),
      ],
    );
  }
}

class RandomButton extends StatelessWidget {
  final VoidCallback onPressed;

  const RandomButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 71, 252, 144),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      ),
      onPressed: onPressed,
      child: const Text(
        '🎲 Get Random Pokémon',
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}


class TitleSection extends StatelessWidget {
  final String title;
  const TitleSection({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // 🔲 Full background color
      width: double.infinity, // 📏 Stretch across the screen
      padding: const EdgeInsets.all(20), // 📦 Inner space
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Center the row content
        crossAxisAlignment: CrossAxisAlignment.center, // Vertically center the content
        children: [
          Image.asset(
            'images/pikachu.jpg',
            width: 20, // Set image width to 20px
            height: 20, // Set image height to 20px to maintain ratio
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 8), // Space between the image and text
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
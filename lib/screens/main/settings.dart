import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mini/utils/provider/settings.dart';
import 'package:provider/provider.dart';
import 'package:mini/models/appThemeModel.dart'; 
import 'package:mini/models/appSecurityType.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<StatefulWidget> createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _serverUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final settings = context.read<SettingsProvider>();
      _serverUrlController.text = settings.serverUrl;
    });
  }

  @override
  void dispose() {
    _serverUrlController.dispose();
    super.dispose();
  }

  Future<void> _pickWallpaper(SettingsProvider provider) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (pickedFile != null) {
      await provider.setWallpaper(pickedFile.path);
    }
  }

  // Функция генерации элементов выпадающего списка
  List<DropdownMenuItem<T>> buildDropdownItems<T>(
    List<T> values, 
    String Function(T) getLabel, 
    {Color Function(T)? getColor}
  ) {
    return values.map((value) {
      return DropdownMenuItem<T>(
        value: value,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (getColor != null) ...[
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(color: getColor(value), shape: BoxShape.circle),
              ),
              const SizedBox(width: 10),
            ],
            Text(getLabel(value)),
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Настройки"),
        centerTitle: true,
        shape: const Border(bottom: BorderSide(color: Colors.black12)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Внешний вид",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              const Divider(),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Тема", style: TextStyle(fontSize: 16)),
                  DropdownButton<AppThemeMode>(
                    value: settings.theme,
                    items: buildDropdownItems(AppThemeMode.values, (t) => t.label), 
                    onChanged: (val) {
                      if (val != null) settings.setTheme(val);
                    },
                  )
                ]
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Основной цвет", style: TextStyle(fontSize: 16)),
                  DropdownButton<AppSeedColor>(
                    value: settings.color,
                    items: buildDropdownItems(AppSeedColor.values, (c) => c.name, getColor: (c) => c.color), 
                    onChanged: (val) {
                      if (val != null) settings.setColor(val);
                    },
                  )
                ]
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Обои в чате", style: TextStyle(fontSize: 16)),
                  Row(
                    children: [
                      if (settings.wallpaperPath != null) ...[
                        GestureDetector(
                          onTap: () => _pickWallpaper(settings),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.file(
                              File(settings.wallpaperPath!),
                              width: 35,
                              height: 35,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.redAccent, size: 20),
                          onPressed: () => settings.setWallpaper(null),
                          tooltip: "Удалить обои",
                        ),
                      ] else ... [
                        OutlinedButton.icon(
                          onPressed: () => _pickWallpaper(settings),
                          icon: const Icon(Icons.image, size: 18),
                          label: const Text("Выбрать"),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
              
              const SizedBox(height: 30),
              const Text(
                "Настройки сети",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              const Divider(),
              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _serverUrlController,
                      style: TextStyle(color: theme.colorScheme.onSurface),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Url сервера",
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      ),
                    )
                  ),
                  const SizedBox(width: 10),
                  FilledButton(
                    onPressed: () {
                      settings.setServerUrl(_serverUrlController.text);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("URL сервера успешно применен")),
                      );
                    },
                    child: const Text("применить")
                  )
                ]
              ),
              const SizedBox(height: 15),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Использовать VPN тунель", style: TextStyle(fontSize: 16)),
                  Switch(
                    value: settings.useVpnTunnel, 
                    onChanged: (value) {
                      settings.setUseVpnTunnel(value);
                    }
                  )
                ]
              ),
              const SizedBox(height: 10),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Тип шифрования", style: TextStyle(fontSize: 16)),
                  DropdownButton<AppSecurityType>(
                    value: settings.securityType,
                    items: buildDropdownItems(AppSecurityType.values, (v) => v.label),
                    onChanged: (val) {
                      if (val != null) settings.setSecurityType(val);
                    },
                  )
                ]
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

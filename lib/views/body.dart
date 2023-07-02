import "package:flutter/material.dart";
import "package:berita/API/index.dart";
import "package:berita/models/index.dart";
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class MainBody extends StatefulWidget {
  const MainBody({super.key});

  @override
  State<MainBody> createState() => _Body();
}

class _Body extends State<MainBody> {
  List<Berita> listBerita = [];
  API api = API();
  TextEditingController search = TextEditingController();

  getData(String q) async {
    listBerita.clear();
    listBerita = await api.getData(q);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData("gaming");
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        elevation: 0,
        title: const Text(
          "Search News",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        color: const Color.fromARGB(31, 232, 232, 232),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: TextFormField(
                textInputAction: TextInputAction.search,
                style: Theme.of(context).textTheme.bodyMedium,
                controller: search,
                onFieldSubmitted: (value) => {getData(value), search.clear()},
                decoration: const InputDecoration(
                    hintText: "search",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    focusColor: Color(0xFF0A9EA2),
                    labelStyle:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
                    prefixIcon: Icon(Icons.search)),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        GestureDetector(
                          child: Text(
                            "${listBerita[index].title} (${DateFormat("dd MMMM yyyy").format(DateTime.parse(listBerita[index].publishedAt))})",
                            style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          onTap: () async {
                            String url = listBerita[index].url;
                            Uri uri = Uri.parse(url);
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(uri);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                        ),
                        const SizedBox(
                            height: 10), // Spasi antara judul dan konten
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                listBerita[index].description,
                                style: TextStyle(
                                  fontSize: screenWidth * 0.03,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 6,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.justify,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ), // Spasi antara konten dan gambar
                            Container(
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: const Offset(
                                        3, 3), // mengontrol arah bayangan
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  listBerita[index].urlToImage,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.network(
                                      "https://cdn.vox-cdn.com/thumbor/OD6A4Oo4W1s-2o9J34_s1twqFO0=/0x0:3000x2000/1200x628/filters:focal(1500x1000:1501x1001)/cdn.vox-cdn.com/uploads/chorus_asset/file/23926023/acastro_STK048_02.jpg",
                                      fit: BoxFit.cover,
                                      cacheHeight: 150,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    color: Colors.black54,
                    indent: 18,
                    endIndent: 18,
                  );
                },
                itemCount: listBerita.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

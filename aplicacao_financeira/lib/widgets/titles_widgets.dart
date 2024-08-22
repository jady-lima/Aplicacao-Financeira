import 'package:aplicacao_financeira/models/stock_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitlesWidgets {
  static Widget buildTitles(String label){
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 69, 142, 201),
          ),
        ),
      ),
    );
  }

  static Widget buildStocksTitles(StockDetails? stock){
    return Center(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.black38, 
            width: 2.0
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),

        leading: Container(
          padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
          width: 150.0,
          child: Text(
            stock?.name ?? "Carregando dados",
            style: GoogleFonts.roboto(
              fontSize: 14.0,
              fontWeight: FontWeight.w800,
              color: const Color.fromARGB(255, 16, 102, 146),
            ),
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        trailing: Container(
          padding: const EdgeInsets.only(left: 160.0, top: 5.0, bottom: 5.0),
          child: Text(
            "R\$${stock?.points ?? "Carregando dados"}",
            style: GoogleFonts.roboto(
              fontSize: 14.0,
              fontWeight: FontWeight.w800,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ),
      )
    );
  }
}
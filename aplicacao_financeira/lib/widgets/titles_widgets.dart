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
            color: Color.fromARGB(179, 21, 57, 101),
          ),
        ),
      ),
    );
  }

  static Widget buildStocksTitles(StockDetails? stock){
    return  Center(
      child: Container(
        margin: const EdgeInsets.all(5.0),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),

          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Colors.black38, 
              width: 2.0
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),

          leading: SizedBox(
            width: 150.0,
            child: Text(
              stock?.name ?? "Carregando dados",
              style: GoogleFonts.roboto(
                fontSize: 14.0,
                fontWeight: FontWeight.w800,
                color: const Color.fromARGB(179, 21, 57, 101),
              ),
              softWrap: true,
              maxLines: 3,
              overflow: TextOverflow.clip,
            ),
          ),

          trailing: Container(
            padding: const EdgeInsets.only(left: 160.0, top: 5.0, bottom: 5.0),
            width: 260,
            alignment: Alignment.centerRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  "${stock?.variation ?? "Carregando dados"}",
                  style: GoogleFonts.roboto(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w800,
                    color: stock != null
                      ? (stock.variation! > 0 ? const Color.fromARGB(198, 53, 150, 57) : const Color.fromARGB(255, 227, 47, 34))
                      : Colors.black,
                  ),
                ),
                
                Text(
                  "R\$${stock?.points ?? "Carregando dados"}",
                  style: GoogleFonts.roboto(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w800,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ],
            )
          ),
        ),
      )
    );
  }
}
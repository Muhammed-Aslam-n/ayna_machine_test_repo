import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget receivedMessagesWidget(
    BuildContext context, {
      required String message,
      required String dateTime,
      bool offlineMessage = false,
    }) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 7.0),
    child: Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * .6),
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: const Color(0xfff9f9f9),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.3),
                    offset: const Offset(0, 2),
                    blurRadius: 5,
                  )
                ],
              ),
              child: offlineMessage
                  ? Column(
                children: [
                  Text(
                    message,
                    style: const TextStyle(
                        color: Colors.black87, fontSize: 14),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Icon(
                    Icons.access_time_sharp,
                    size: 11,
                  ),
                ],
              )
                  : Text(
                message,
                style:
                const TextStyle(color: Colors.black87, fontSize: 14),
              ),
            ),
          ],
        ),
        const SizedBox(width: 6),
        Text(
          DateFormat('h:mm a').format(DateTime.parse(dateTime)).toString(),
          style: const TextStyle(color: Colors.grey, fontSize: 8),
        ),
      ],
    ),
  );
}

Widget sentMessageWidget(
    BuildContext context, {
      required String message,
      required String dateTime,
      bool offlineMessage = false,
    }) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 7.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(
          DateFormat('h:mm a')
              .format(
            DateTime.parse(dateTime),
          )
              .toString(),
          style: const TextStyle(color: Colors.grey, fontSize: 8),
        ),
        const SizedBox(width: 15),
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * .6,
          ),
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Colors.pink.shade300,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.3),
                offset: const Offset(0, 2),
                blurRadius: 5,
              )
            ],
          ),
          child: offlineMessage
              ? Column(
            children: [
              Text(
                message,
                style:
                const TextStyle(color: Colors.black87, fontSize: 14),
              ),
              const SizedBox(
                height: 5,
              ),
              const Icon(
                Icons.access_time_sharp,
                size: 11,
              ),
            ],
          )
              : Text(
            message,
            style: const TextStyle(color: Colors.black87, fontSize: 14),
          ),
        ),
      ],
    ),
  );
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seu_lourival/app/data/models/maintenance_contact_model.dart';
import 'package:seu_lourival/core/values/colors.dart';
import 'package:seu_lourival/global_widgets/design_system/text/text.dart';

enum MaintenanceContactListTileAction {
  whatsapp,
  call,
  delete,
}

class MaintenanceContactListTile extends StatelessWidget {
  final MaintenanceContactModel contact;
  final Function(MaintenanceContactListTileAction) onTap;
  final ScrollController _scrollController =
      ScrollController(initialScrollOffset: 0);
  MaintenanceContactListTile({
    Key? key,
    required this.contact,
    required this.onTap,
  }) : super(key: key);

  Widget _buildGestureIcon({
    required IconData icon,
    required MaintenanceContactListTileAction action,
  }) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          color: DSColors.primary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      onPressed: () {
        onTap(action);
      },
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Icon(
          icon,
          size: 30,
          color: DSColors.primary,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 5,
      child: ExpansionTile(
        iconColor: DSColors.primary,
        textColor: DSColors.primary,
        title: DSText.lg(contact.name.capitalizeFirst ?? ""),
        subtitle: Scrollbar(
          thumbVisibility: true,
          controller: _scrollController,
          scrollbarOrientation: ScrollbarOrientation.bottom,
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(vertical: 8),
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: 8,
              children: contact.category.map((category) {
                return Chip(
                  backgroundColor: DSColors.primary,
                  elevation: 3,
                  labelPadding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  labelStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  label: Text(category),
                );
              }).toList(),
            ),
          ),
        ),
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(left: 16, bottom: 8),
            child: Text(
              contact.phone,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildGestureIcon(
                icon: Icons.whatsapp,
                action: MaintenanceContactListTileAction.whatsapp,
              ),
              _buildGestureIcon(
                icon: Icons.phone,
                action: MaintenanceContactListTileAction.call,
              ),
              if (true)
                _buildGestureIcon(
                  icon: Icons.delete,
                  action: MaintenanceContactListTileAction.delete,
                ),
            ],
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}

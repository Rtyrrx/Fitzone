import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/restaurant_item.dart';
import '../models/cart_item.dart';
import '../services/cart_manager.dart';
import 'cart_control.dart';

class ItemDetails extends StatefulWidget {
  final MembershipPlan item;
  final CartManager cartManager;
  final VoidCallback quantityUpdated;

  const ItemDetails({
    super.key,
    required this.item,
    required this.cartManager,
    required this.quantityUpdated,
  });

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  Widget _mostLikedBadge(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.thumb_up, size: 16, color: colorScheme.onPrimaryContainer),
          const SizedBox(width: 4),
          Text(
            'Popular',
            style: TextStyle(
              color: colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemImage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: imageUrl.isNotEmpty
          ? Image.network(
              imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  child: Icon(
                    Icons.fitness_center,
                    size: 60,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                );
              },
            )
          : Container(
              height: 200,
              color: Theme.of(context).colorScheme.secondaryContainer,
              child: Icon(
                Icons.fitness_center,
                size: 60,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
    );
  }

  Widget _addToCartControl(MembershipPlan item) {
    return CartControl(
      addToCart: (quantity) {
        final cartItem = CartItem(
          id: const Uuid().v4(),
          item: item,
          quantity: quantity,
        );
        widget.cartManager.addItem(cartItem);
        widget.quantityUpdated();
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.item.name,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _mostLikedBadge(colorScheme),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            widget.item.duration,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          _itemImage(widget.item.imageUrl),
          const SizedBox(height: 16),
          Text(
            widget.item.description,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 8),
          Text(
            '\$${widget.item.price.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 24),
          _addToCartControl(widget.item),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

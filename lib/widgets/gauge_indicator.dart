import 'package:flutter/material.dart';

class GaugeIndicator extends StatelessWidget {
  final double value;
  final double min;
  final double max;
  final double minRecommended;
  final double maxRecommended;
  final String label;
  final String unit;

  const GaugeIndicator({
    Key? key,
    required this.value,
    required this.min,
    required this.max,
    required this.minRecommended,
    required this.maxRecommended,
    required this.label,
    this.unit = '%',
  }) : super(key: key);

  Color _getIndicatorColor() {
    if (value < minRecommended) {
      return Colors.orange;
    } else if (value > maxRecommended) {
      return Colors.red;
    }
    return Colors.green;
  }

  String _getStatusText() {
    if (value < minRecommended) {
      return 'Too Low';
    } else if (value > maxRecommended) {
      return 'Too High';
    }
    return 'Optimal';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[100],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: _getIndicatorColor().withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _getIndicatorColor()),
                ),
                child: Text(
                  _getStatusText(),
                  style: TextStyle(
                    color: _getIndicatorColor(),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Stack(
            children: [
              // Background track
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              // Recommended range
              Positioned(
                left: (minRecommended - min) / (max - min) * MediaQuery.of(context).size.width * 0.8,
                width: (maxRecommended - minRecommended) / (max - min) * MediaQuery.of(context).size.width * 0.8,
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              // Current value indicator
              Positioned(
                left: (value - min) / (max - min) * MediaQuery.of(context).size.width * 0.8 - 8,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: _getIndicatorColor(),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${min.toStringAsFixed(1)}$unit',
                style: TextStyle(color: Colors.grey[600]),
              ),
              Text(
                'Current: ${value.toStringAsFixed(1)}$unit',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '${max.toStringAsFixed(1)}$unit',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Recommended: ${minRecommended.toStringAsFixed(1)}-${maxRecommended.toStringAsFixed(1)}$unit',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
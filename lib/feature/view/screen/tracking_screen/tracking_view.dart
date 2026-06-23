import 'dart:async';

import 'package:flutter/material.dart';

import '../widgets/tracking/tracking_bottom_bar.dart';
import '../widgets/tracking/tracking_header.dart';
import '../widgets/tracking/tracking_step_tile.dart';

enum OrderStatus { pending, processing, shipped, outForDelivery, delivered }

class TrackingView extends StatefulWidget {
  final String trackingId;

  const TrackingView({super.key, required this.trackingId});

  @override
  State<TrackingView> createState() => _TrackingViewState();
}

class _TrackingViewState extends State<TrackingView> {
  late Timer _timer;
  OrderStatus _status = OrderStatus.pending;

  final List<OrderStatus> _steps = const [
    OrderStatus.pending,
    OrderStatus.processing,
    OrderStatus.shipped,
    OrderStatus.outForDelivery,
    OrderStatus.delivered,
  ];

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 3), (t) {
      final idx = _steps.indexOf(_status);
      if (idx < 0) return;
      if (idx >= _steps.length - 1) {
        t.cancel();
        return;
      }
      setState(() {
        _status = _steps[idx + 1];
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String get _statusLabel {
    switch (_status) {
      case OrderStatus.pending:
        return 'Order confirmed';
      case OrderStatus.processing:
        return 'Preparing your package';
      case OrderStatus.shipped:
        return 'Shipped';
      case OrderStatus.outForDelivery:
        return 'Out for delivery';
      case OrderStatus.delivered:
        return 'Delivered';
    }
  }

  double get _progress {
    final idx = _steps.indexOf(_status);
    return (idx + 1) / _steps.length;
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery Tracking'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          children: [
            TrackingHeader(
                trackingId: widget.trackingId, statusText: _statusLabel),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: scheme.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: scheme.surfaceContainerHighest.withValues(alpha: 0.6),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Timeline',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: scheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 10),
                  LinearProgressIndicator(
                    value: _progress,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(999),
                    backgroundColor:
                        scheme.surfaceContainerHighest.withValues(alpha: 0.25),
                    color: scheme.primary,
                  ),
                  const SizedBox(height: 14),
                  Column(
                    children: [
                      TrackingStepTile(
                        icon: Icons.receipt_long_outlined,
                        label: 'Confirmed',
                        isDone: _steps.indexOf(_status) >= 0,
                        isActive: _status == OrderStatus.pending,
                      ),
                      TrackingStepTile(
                        icon: Icons.build_circle_outlined,
                        label: 'Processing',
                        isDone: _steps.indexOf(_status) >= 1,
                        isActive: _status == OrderStatus.processing,
                      ),
                      TrackingStepTile(
                        icon: Icons.local_shipping_outlined,
                        label: 'Shipped',
                        isDone: _steps.indexOf(_status) >= 2,
                        isActive: _status == OrderStatus.shipped,
                      ),
                      TrackingStepTile(
                        icon: Icons.delivery_dining_outlined,
                        label: 'Out for delivery',
                        isDone: _steps.indexOf(_status) >= 3,
                        isActive: _status == OrderStatus.outForDelivery,
                      ),
                      TrackingStepTile(
                        icon: Icons.home_outlined,
                        label: 'Delivered',
                        isDone: _steps.indexOf(_status) >= 4,
                        isActive: _status == OrderStatus.delivered,
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 14),
            TrackingBottomBar(statusLabel: _statusLabel),
            const SizedBox(height: 8),
            Text(
              'Tracking updates are simulated for this demo app.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: scheme.onSurface.withValues(alpha: 0.55),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/branches/brach_drawer_screen.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';

/// claims_screen.dart
///
/// UI-only implementation of a Claims Screen for Flutter.
/// - Shows a searchable, filterable list of claims
/// - Manager actions: Approve / Reject / Add remarks (UI only)
/// - Filters: Pending | Approved | Rejected
///
/// Drop this file into your lib/ folder and open BrachClaimScreen in your app.

enum ClaimStatus { pending, approved, rejected }

class Claim {
  final String id;
  final String warrantyNumber;
  final String customerName;
  final String description;
  ClaimStatus status;
  String? remarks;

  Claim({
    required this.id,
    required this.warrantyNumber,
    required this.customerName,
    required this.description,
    this.status = ClaimStatus.pending,
    this.remarks,
  });
}

class BrachClaimScreen extends StatefulWidget {
  const BrachClaimScreen({super.key});

  @override
  State<BrachClaimScreen> createState() => _BrachClaimScreenState();
}

class _BrachClaimScreenState extends State<BrachClaimScreen>
    with SingleTickerProviderStateMixin {
  final List<Claim> _allClaims = List.generate(
    12,
    (i) => Claim(
      id: 'CLM-${1000 + i}',
      warrantyNumber: 'WN-${2000 + i}',
      customerName: 'Customer ${i + 1}',
      description: 'Description for claim ${i + 1}',
      status: i % 3 == 0
          ? ClaimStatus.pending
          : (i % 3 == 1 ? ClaimStatus.approved : ClaimStatus.rejected),
    ),
  );

  ClaimStatus? _selectedFilter; // null means All / or use tabs to pick
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      setState(() {
        _selectedFilter =
            _tabController.index == 0
                ? ClaimStatus.pending
                : (_tabController.index == 1 ? ClaimStatus.approved : ClaimStatus.rejected);
      });
    });

    // initialize default filter to Pending
    _selectedFilter = ClaimStatus.pending;
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Claim> get _filteredClaims {
    final q = _searchQuery.trim().toLowerCase();
    return _allClaims.where((c) {
      if (_selectedFilter != null && c.status != _selectedFilter) return false;
      if (q.isEmpty) return true;
      return c.id.toLowerCase().contains(q) ||
          c.warrantyNumber.toLowerCase().contains(q) ||
          c.customerName.toLowerCase().contains(q);
    }).toList();
  }

  void _showActionSheet(Claim claim) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.check_circle_outline),
              title: const Text('Approve claim'),
              onTap: () {
                Navigator.of(context).pop();
                _updateClaimStatus(claim, ClaimStatus.approved);
              },
            ),
            ListTile(
              leading: const Icon(Icons.cancel_outlined),
              title: const Text('Reject claim'),
              onTap: () {
                Navigator.of(context).pop();
                _updateClaimStatus(claim, ClaimStatus.rejected);
              },
            ),
            ListTile(
              leading: const Icon(Icons.note_add_outlined),
              title: const Text('Add / Edit remarks'),
              onTap: () {
                Navigator.of(context).pop();
                _showRemarksDialog(claim);
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _updateClaimStatus(Claim claim, ClaimStatus status) async {
    // UI-only: update local state
    setState(() {
      claim.status = status;
    });

    // show a confirmation snackbar with undo
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Claim ${claim.id} marked ${_statusLabel(status)}'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              claim.status = ClaimStatus.pending;
            });
          },
        ),
      ),
    );
  }

  void _showRemarksDialog(Claim claim) {
    final TextEditingController ctrl = TextEditingController(text: claim.remarks);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Remarks for ${claim.id}'),
        content: TextField(
          controller: ctrl,
          minLines: 3,
          maxLines: 6,
          decoration: const InputDecoration(
            hintText: 'Add remarks (optional)',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                claim.remarks = ctrl.text.trim().isEmpty ? null : ctrl.text.trim();
              });
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  String _statusLabel(ClaimStatus s) {
    switch (s) {
      case ClaimStatus.pending:
        return 'Pending';
      case ClaimStatus.approved:
        return 'Approved';
      case ClaimStatus.rejected:
        return 'Rejected';
    }
  }

  Color _statusColor(ClaimStatus s) {
    switch (s) {
      case ClaimStatus.pending:
        return Colors.orange;
      case ClaimStatus.approved:
        return Colors.green;
      case ClaimStatus.rejected:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         drawer: BranchDrawerScreen(role: 'Manager'),
      appBar: AppBar(
        title: const Text('Claims',),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(112),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        
                        controller: _searchController,
                        onChanged: (v) => setState(() => _searchQuery = v),
                        decoration: InputDecoration(
                          hintText: 'Search by Claim ID / Warranty No / Customer name',
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: _searchQuery.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    _searchController.clear();
                                    setState(() => _searchQuery = '');
                                  },
                                )
                              : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.filter_list),
                      onPressed: () {
                        // optional: present advanced filters
                        _showAdvancedFilters();
                      },
                    ),
                  ],
                ),
              ),
              TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Pending'),
                  Tab(text: 'Approved'),
                  Tab(text: 'Rejected'),
                ],
              ),
            ],
          ),
        ),
      ),
      body: _filteredClaims.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.inbox, size: 64, color: Colors.grey),
                  SizedBox(height: 12),
                  Text('No claims found', style: TextStyle(fontSize: 16)),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: _filteredClaims.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final claim = _filteredClaims[index];
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    onTap: () => _showClaimDetails(claim),
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        claim.id,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: _statusColor(claim.status).withOpacity(0.12),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        _statusLabel(claim.status),
                                        style: TextStyle(
                                          color: _statusColor(claim.status),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text('Warranty: ${claim.warrantyNumber}'),
                                const SizedBox(height: 4),
                                Text('Customer: ${claim.customerName}'),
                                const SizedBox(height: 8),
                                Text(
                                  claim.description,
                                  style: const TextStyle(color: Colors.black54),
                                ),
                                if (claim.remarks != null) ...[
                                  const SizedBox(height: 8),
                                  Text('Remarks: ${claim.remarks!}', style: const TextStyle(fontStyle: FontStyle.italic)),
                                ],
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.more_vert),
                                onPressed: () => _showActionSheet(claim),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // UI-only placeholder for "Add Claim" flow
          _showAddClaimDialog();
        },
        label: const Text('Add Claim'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  void _showClaimDetails(Claim claim) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        maxChildSize: 0.9,
        builder: (_, controller) => SingleChildScrollView(
          controller: controller,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(claim.id, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Chip(
                      label: Text(_statusLabel(claim.status)),
                      backgroundColor: _statusColor(claim.status).withOpacity(0.14),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text('Warranty: ${claim.warrantyNumber}'),
                const SizedBox(height: 8),
                Text('Customer: ${claim.customerName}'),
                const SizedBox(height: 12),
                Text('Description', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 6),
                Text(claim.description),
                const SizedBox(height: 12),
                Text('Remarks', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 6),
                Text(claim.remarks ?? '— No remarks —'),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _updateClaimStatus(claim, ClaimStatus.approved),
                        icon: const Icon(Icons.check),
                        label: const Text('Approve'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                        onPressed: () => _updateClaimStatus(claim, ClaimStatus.rejected),
                        icon: const Icon(Icons.close),
                        label: const Text('Reject'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Center(
                  child: TextButton(
                    onPressed: () => _showRemarksDialog(claim),
                    child: const Text('Add / Edit Remarks'),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAdvancedFilters() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Advanced Filters'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Example: Date range, customer, product, etc. (UI placeholders)
            TextFormField(
              decoration: const InputDecoration(labelText: 'Customer name'),
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Warranty number'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Close')),
          ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Apply')),
        ],
      ),
    );
  }

  void _showAddClaimDialog() {
    final idCtrl = TextEditingController();
    final wnCtrl = TextEditingController();
    final customerCtrl = TextEditingController();
    final descCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Claim (UI-only)'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: idCtrl, decoration: const InputDecoration(labelText: 'Claim ID')),
              TextField(controller: wnCtrl, decoration: const InputDecoration(labelText: 'Warranty No')),
              TextField(controller: customerCtrl, decoration: const InputDecoration(labelText: 'Customer name')),
              TextField(controller: descCtrl, decoration: const InputDecoration(labelText: 'Description')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _allClaims.insert(
                  0,
                  Claim(
                    id: idCtrl.text.isEmpty ? 'CLM-${10000 + _allClaims.length}' : idCtrl.text,
                    warrantyNumber: wnCtrl.text.isEmpty ? 'WN-NEW' : wnCtrl.text,
                    customerName: customerCtrl.text.isEmpty ? 'Unnamed' : customerCtrl.text,
                    description: descCtrl.text.isEmpty ? 'No description' : descCtrl.text,
                    status: ClaimStatus.pending,
                  ),
                );
              });
              Navigator.of(context).pop();
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}

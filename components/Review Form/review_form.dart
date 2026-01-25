import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ReviewForm extends StatefulWidget {
  const ReviewForm({super.key});

  @override
  State<ReviewForm> createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  double _rating = 0;
  double _recommendationLevel = 5; // New: 1-10 scale
  final List<String> _selectedLikes = [];
  final List<XFile> _images = [];
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _reviewController = TextEditingController();

  // More fields for a better UX
  String _selectedService = "In-store";
  final List<String> _serviceOptions = ["In-store", "Online", "Delivery", "Support"];
  final List<String> _tags = ["Quality", "Fast Delivery", "Packaging", "Service", "Price", "Reliability", "Support"];

  void _onStarTap(double rating) {
    HapticFeedback.mediumImpact();
    setState(() => _rating = rating);
  }

  Future<void> _pickImage() async {
    if (_images.length >= 3) return;
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) setState(() => _images.add(image));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.close, color: Colors.black),
        title: const Text("Write a Review", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader("How was your experience?", "Tap a star to rate"),
            const SizedBox(height: 10),

            // FIXED: Stars centered to prevent Right Overflow
            Center(child: _buildStarRating()),

            const SizedBox(height: 30),
            _buildSectionHeader("What stood out?", "Select all that apply"),
            const SizedBox(height: 12),

            // FIXED: Wrap prevents horizontal overflow for tags
            Wrap(
              spacing: 8,
              runSpacing: 10,
              children: _tags.map((tag) => _buildChoiceChip(tag)).toList(),
            ),

            const SizedBox(height: 30),
            _buildSectionHeader("Service Type", "Where did you interact with us?"),
            const SizedBox(height: 12),
            _buildServiceDropdown(),

            const SizedBox(height: 30),
            _buildSectionHeader("Likelihood to recommend", "${_recommendationLevel.toInt()}/10"),
            Slider(
              value: _recommendationLevel,
              min: 1, max: 10,
              divisions: 9,
              activeColor: Colors.blueAccent,
              onChanged: (v) => setState(() => _recommendationLevel = v),
            ),

            const SizedBox(height: 20),
            _buildSectionHeader("Add a written review", "Optional but helpful"),
            const SizedBox(height: 12),
            _buildTextField(),

            const SizedBox(height: 30),
            _buildSectionHeader("Add Photos", "Max 3 photos"),
            const SizedBox(height: 12),
            _buildImagePickerRow(),

            const SizedBox(height: 40),
            _buildSubmitButton(),
            const Center(child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text("OPTIONAL ANONYMOUS REVIEW", style: TextStyle(color: Colors.grey, fontSize: 11)),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String sub) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(sub, style: const TextStyle(color: Colors.grey, fontSize: 13)),
      ],
    );
  }

  Widget _buildStarRating() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) => GestureDetector(
        onTap: () => _onStarTap(index + 1.0),
        child: Icon(
          index < _rating ? Icons.star_rounded : Icons.star_outline_rounded,
          color: index < _rating ? Colors.amber : Colors.grey[300],
          size: 42,
        ),
      )),
    );
  }

  Widget _buildChoiceChip(String label) {
    bool isSelected = _selectedLikes.contains(label);
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (v) {
        HapticFeedback.selectionClick();
        setState(() => v ? _selectedLikes.add(label) : _selectedLikes.remove(label));
      },
      selectedColor: Colors.blueAccent,
      labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black, fontSize: 13),
      backgroundColor: Colors.grey[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      side: BorderSide(color: isSelected ? Colors.blueAccent : Colors.grey[200]!),
    );
  }

  Widget _buildServiceDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedService,
          isExpanded: true,
          items: _serviceOptions.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (v) => setState(() => _selectedService = v!),
        ),
      ),
    );
  }

  Widget _buildTextField() {
    return TextField(
      controller: _reviewController,
      maxLines: 4,
      decoration: InputDecoration(
        hintText: "Tell us more about your experience...",
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
      ),
    );
  }

  Widget _buildImagePickerRow() {
    return Row(
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            width: 70, height: 70,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!, style: BorderStyle.none),
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(Icons.camera_alt_outlined, color: Colors.grey),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: SizedBox(
            height: 70,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _images.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) => ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.file(File(_images[index].path), width: 70, height: 70, fit: BoxFit.cover),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF101820),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        onPressed: () {},
        child: const Text("Submit Review", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AudioController extends GetxController {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  // Reactive list of songs
  var songs = <SongModel>[].obs;
  var isLoading = true.obs;
  var error = RxnString();

  // Flag to prevent concurrent permission requests
  bool _isRequestingPermission = false;

  @override
  void onInit() {
    super.onInit();
    // CRITICAL FIX: Run permission handling immediately on init.
    // The previous Future.delayed can cause conflicts with native callbacks.
    _handlePermissionAndLoad();
  }

  /// Handle permission request and load songs. Only uses default native Android prompts.
  Future<void> _handlePermissionAndLoad() async {
    // Prevent re-entry while a request is in progress
    if (_isRequestingPermission) return;
    _isRequestingPermission = true;

    isLoading.value = true;
    error.value = null;

    try {
      // 1. Check permission status
      bool hasPermission = await _audioQuery.permissionsStatus();

      // 2. Request permission if not granted (uses native Android prompt).
      if (!hasPermission) {
        // Await the permission request result directly. This is the cleanest way
        // to handle the native callback without causing a race condition.
        hasPermission = await _audioQuery.permissionsRequest();
      }

      // 3. If permission is now granted, load songs.
      if (hasPermission) {
        await _loadSongs();
      } else {
        // Permission denied
        error.value = "Storage permission denied. Please grant permission in app settings to load audio files.";
      }
    } catch (e) {
      // Catch any plugin or system error
      debugPrint("Permission or loading error: $e");
      error.value = "An error occurred during audio loading: ${e.toString()}";
    } finally {
      // Ensure the flags are reset
      isLoading.value = false;
      _isRequestingPermission = false;
    }
  }

  /// Load all songs from device
  Future<void> _loadSongs() async {
    try {
      songs.value = await _audioQuery.querySongs(
        sortType: SongSortType.TITLE,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true,
      );
    } catch (e) {
      // Catch any audio query error
      debugPrint("Audio query error: $e");
      error.value = e.toString();
    }
  }
}
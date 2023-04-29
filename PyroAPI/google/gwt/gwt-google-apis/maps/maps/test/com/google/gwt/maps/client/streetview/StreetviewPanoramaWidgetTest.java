/*
 * Copyright 2010 Google Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 */
package com.google.gwt.maps.client.streetview;

import com.google.gwt.maps.client.MapsTestCase;
import com.google.gwt.maps.client.TestUtilities;
import com.google.gwt.maps.client.event.StreetviewErrorHandler;
import com.google.gwt.maps.client.event.StreetviewInitializedHandler;
import com.google.gwt.maps.client.event.StreetviewPitchChangedHandler;
import com.google.gwt.maps.client.event.StreetviewYawChangedHandler;
import com.google.gwt.maps.client.event.StreetviewZoomChangedHandler;
import com.google.gwt.maps.client.event.StreetviewErrorHandler.StreetviewErrorEvent;
import com.google.gwt.maps.client.event.StreetviewPitchChangedHandler.StreetviewPitchChangedEvent;
import com.google.gwt.maps.client.event.StreetviewYawChangedHandler.StreetviewYawChangedEvent;
import com.google.gwt.maps.client.event.StreetviewZoomChangedHandler.StreetviewZoomChangedEvent;
import com.google.gwt.maps.client.geom.LatLng;
import com.google.gwt.maps.client.streetview.StreetviewPanoramaWidget.ErrorValue;
import com.google.gwt.user.client.Timer;
import com.google.gwt.user.client.ui.RootPanel;

/**
 * Tests for {@link StreetviewPanoramaWidget} and supporting classes.
 */
public class StreetviewPanoramaWidgetTest extends MapsTestCase {

  /**
   * HACK: Workaround to avoid running these tests on FF. Tests including Flash
   * plugin fail on FF if screen of the tester machine is locked.
   */
  private static native boolean isFirefoxOnWindows() /*-{
    var ua = navigator.userAgent.toLowerCase();
    return (ua.indexOf("firefox") != -1) && (ua.indexOf("windows") != -1);
  }-*/;

  private StreetviewPanoramaWidget panorama;

  /**
   * Using different module to force browser refresh for
   * {@link StreetviewPanoramaWidget} tests.
   */
  @Override
  public String getModuleName() {
    return "com.google.gwt.maps.GoogleStreetviewTest";
  }

  public void testAddErrorHandler() {
    /**
     * HACK: Workaround to avoid running these tests on FF. Tests including
     * Flash plugin fail on FF if screen of the tester machine is locked.
     */
    if (isFirefoxOnWindows()) {
      return;
    }
    loadApi(new Runnable() {
      public void run() {
        final LatLng mountEverest = LatLng.newInstance(27.988056, 86.925278);
        StreetviewPanoramaOptions options = StreetviewPanoramaOptions.newInstance();
        options.setLatLng(mountEverest);

        panorama = new StreetviewPanoramaWidget(options);
        panorama.setSize("500px", "300px");

        panorama.addErrorHandler(new StreetviewErrorHandler() {
          public void onError(StreetviewErrorEvent event) {
            assertEquals(ErrorValue.NO_NEARBY_PANO.getErrorCode(),
                event.getErrorCode());
            finishTest();
          }
        });

        RootPanel.get().add(panorama);
      }
    }, false);
  }

  public void testAddInitializedHandler() {
    /**
     * HACK: Workaround to avoid running these tests on FF. Tests including
     * Flash plugin fail on FF if screen of the tester machine is locked.
     */
    if (isFirefoxOnWindows()) {
      return;
    }
    loadApi(new Runnable() {
      public void run() {
        final LatLng tenthStreet = LatLng.newInstance(33.7814839, -84.3879353);
        final Pov pov = Pov.newInstance();
        pov.setPitch(-5).setYaw(180).setZoom(1);

        StreetviewPanoramaOptions options = StreetviewPanoramaOptions.newInstance();
        options.setLatLng(tenthStreet);
        options.setPov(pov);

        panorama = new StreetviewPanoramaWidget(options);
        panorama.setSize("500px", "300px");

        panorama.addInitializedHandler(new StreetviewInitializedHandler() {
          public void onInitialized(StreetviewInitializedEvent event) {
            LatLng point = event.getLocation().getLatLng();
            assertEquals(tenthStreet.getLatitude(), point.getLatitude(), 1e-2);
            assertEquals(tenthStreet.getLongitude(), point.getLongitude(), 1e-2);

            Pov actualPov = event.getLocation().getPov();
            assertEquals(pov.getPitch(), actualPov.getPitch(), 1e-2);
            assertEquals(pov.getYaw(), actualPov.getYaw(), 1e-2);
            // Intentionally not testing zoom, as it behaves unpredictably

            assertEquals(panorama, event.getSender());
            assertNotNull(event.getLocation().getPanoId());
            assertNotNull(event.getLocation().getDescription());
            finishTest();
          }
        });

        RootPanel.get().add(panorama);
      }
    }, false);
  }

  public void testAddInitializedHandler_changedLocation() {
    /**
     * HACK: Workaround to avoid running these tests on FF. Tests including
     * Flash plugin fail on FF if screen of the tester machine is locked.
     */
    if (isFirefoxOnWindows()) {
      return;
    }
    loadApi(new Runnable() {
      public void run() {
        final LatLng tenthStreet = LatLng.newInstance(33.7814839, -84.3879353);
        final LatLng manhattan = LatLng.newInstance(40.728333, -73.994167);
        panorama = newDefaultPanorama();

        panorama.addInitializedHandler(new StreetviewInitializedHandler() {
          public void onInitialized(StreetviewInitializedEvent event) {
            LatLng point = event.getLocation().getLatLng();

            // If on tenth street in Atlanta
            if (Math.abs(tenthStreet.getLatitude() - point.getLatitude()) < 1e-2
                && Math.abs(tenthStreet.getLongitude() - point.getLongitude()) < 1e-2) {
              // Event triggered when panorama was initialized first time
              panorama.setLocationAndPov(manhattan, Pov.newInstance());
            } else {
              // Event triggered when panorama was initialized again after
              // setLocationAndPov() was invoked
              assertEquals(manhattan.getLatitude(), point.getLatitude(), 1e-2);
              assertEquals(manhattan.getLongitude(), point.getLongitude(), 1e-2);
              finishTest();
            }
          }
        });

        RootPanel.get().add(panorama);
      }
    }, false);
  }

  public void testAddPitchChangedHandler() {
    /**
     * HACK: Workaround to avoid running these tests on FF. Tests including
     * Flash plugin fail on FF if screen of the tester machine is locked.
     */
    if (isFirefoxOnWindows()) {
      return;
    }
    loadApi(new Runnable() {
      public void run() {
        panorama = newDefaultPanorama();

        final double pitch = 30;

        panorama.addPitchChangedHandler(new StreetviewPitchChangedHandler() {
          public void onPitchChanged(StreetviewPitchChangedEvent event) {
            assertEquals(panorama, event.getSender());
            // 'If' instead of 'assert', as this event might be triggered few
            // times before we invoke setPov() method
            if (Math.abs(pitch - event.getPitch()) < 1e-2) {
              finishTest();
            }
          }
        });

        panorama.addInitializedHandler(new StreetviewInitializedHandler() {
          public void onInitialized(StreetviewInitializedEvent event) {
            Pov pov = Pov.newInstance().setPitch(pitch);
            panorama.setPov(pov);
          }
        });

        RootPanel.get().add(panorama);
      }
    }, false);
  }

  public void testAddYawChangedHandler() {
    /**
     * HACK: Workaround to avoid running these tests on FF. Tests including
     * Flash plugin fail on FF if screen of the tester machine is locked.
     */
    if (isFirefoxOnWindows()) {
      return;
    }
    loadApi(new Runnable() {
      public void run() {
        panorama = newDefaultPanorama();

        final double yaw = 180;

        panorama.addYawChangedHandler(new StreetviewYawChangedHandler() {
          public void onYawChanged(StreetviewYawChangedEvent event) {
            assertEquals(panorama, event.getSender());
            // 'If' instead of 'assert', as this event might be triggered few
            // times before we invoke setPov() method
            if (Math.abs(yaw - event.getYaw()) < 1e-2) {
              finishTest();
            }
          }
        });

        panorama.addInitializedHandler(new StreetviewInitializedHandler() {
          public void onInitialized(StreetviewInitializedEvent event) {
            Pov pov = Pov.newInstance().setYaw(yaw);
            panorama.setPov(pov);
          }
        });

        RootPanel.get().add(panorama);
      }
    }, false);
  }

  public void testAddZoomChangedHandler() {
    /**
     * HACK: Workaround to avoid running these tests on FF. Tests including
     * Flash plugin fail on FF if screen of the tester machine is locked.
     */
    if (isFirefoxOnWindows()) {
      return;
    }
    loadApi(new Runnable() {
      public void run() {
        panorama = newDefaultPanorama();

        final double zoom = 1;

        panorama.addZoomChangedHandler(new StreetviewZoomChangedHandler() {
          public void onZoomChanged(StreetviewZoomChangedEvent event) {
            assertEquals(panorama, event.getSender());
            // 'If' instead of 'assert', as this event might be triggered few
            // times before we invoke setPov() method
            if (Math.abs(zoom - event.getZoom()) < 1e-2) {
              finishTest();
            }
          }
        });

        panorama.addInitializedHandler(new StreetviewInitializedHandler() {
          public void onInitialized(StreetviewInitializedEvent event) {
            Pov pov = Pov.newInstance().setZoom(zoom);
            panorama.setPov(pov);
          }
        });

        RootPanel.get().add(panorama);
      }
    }, false);
  }

  /**
   * Runs before every test method.
   */
  @Override
  protected void gwtSetUp() throws Exception {
    super.gwtSetUp();
    TestUtilities.cleanDom();
    panorama = null;
  }

  /**
   * Cleaning after test.
   */
  @Override
  protected void gwtTearDown() throws Exception {
    if (panorama != null) {
      panorama.remove();
    }
    super.gwtTearDown();
  }

  private StreetviewPanoramaWidget newDefaultPanorama() {
    LatLng tenthStreet = LatLng.newInstance(33.7814839, -84.3879353);
    StreetviewPanoramaOptions options = StreetviewPanoramaOptions.newInstance();
    options.setLatLng(tenthStreet);
    StreetviewPanoramaWidget panorama = new StreetviewPanoramaWidget(options);
    panorama.setSize("500px", "300px");
    return panorama;
  }
}

/*
 * Copyright 2009 Google Inc.
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
package com.google.gwt.maps;

import com.google.gwt.junit.tools.GWTTestSuite;
import com.google.gwt.maps.client.MapsAjaxLoader;

import junit.framework.Test;
import junit.framework.TestSuite;

/**
 * TestSuite for the Maps API loaded from the AjaxLoader class. One major
 * difference is that the Maps API key is specified in code instead of the GWT
 * module or hosted .html file.
 * 
 */
public class MapsAjaxLoaderSuite extends GWTTestSuite {
  public static Test suite() {
    TestSuite suite = new TestSuite("Test for the Maps API");
    suite.addTestSuite(MapsAjaxLoader.class);
    return suite;
  }
}

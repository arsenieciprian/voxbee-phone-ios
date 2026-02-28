/*
 * Copyright (c) 2010-2023 Belledonne Communications SARL.
 *
 * This file is part of Linphone
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

import SwiftUI

struct AssistantView: View {
    
    @ObservedObject private var coreContext = CoreContext.shared
    
    // Adăugăm managerul de permisiuni pentru a decide ce ecran afișăm
    @ObservedObject private var permissionManager = PermissionManager.shared
    
    // Motorul pentru login
    @StateObject private var accountLoginViewModel = AccountLoginViewModel()
    
    var body: some View {
        // Pasul 1: Dacă permisiunile NU au fost afișate încă, pornim cu ele
        if !permissionManager.allPermissionsHaveBeenDisplayed {
            PermissionsFragment()
        }
        // Pasul 2: Dacă s-a trecut de permisiuni și suntem logați, verificăm modul de profil
        else if SharedMainViewModel.shared.displayProfileMode && coreContext.loggedIn {
            ProfileModeFragment()
        }
        // Pasul 3: Dacă totul este pregătit, afișăm direct formularul de login
        else {
            NavigationView {
                ThirdPartySipAccountLoginFragment(accountLoginViewModel: accountLoginViewModel)
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

#Preview {
    AssistantView()
}

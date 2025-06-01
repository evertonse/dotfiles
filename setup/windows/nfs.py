#
#
#
# :: Places that have helped me Debug ::
#
# Portmap daemon starts failed: https://github.com/winnfsd/winnfsd/issues/63
# This NFS only supports version 3 ok?
# Mount daemon starts failed (check if port 1058 is not already in use ;) ): https://github.com/winnfsd/winnfsd/issues/95
# dameon starts failed: https://github.com/winnfsd/winnfsd/issues/72 (BEST ONE)
#
#
#
#
#


import urllib.request
import urllib.error
import json
import os
from pathlib import Path, PureWindowsPath

def run(x):
    print(x)
    os.system(x)

def get_latest_release(repo):
    # GitHub API URL for the latest release
    url = f'https://api.github.com/repos/{repo}/releases/latest'
    
    try:
        with urllib.request.urlopen(url) as response:
            data = response.read()
            release_info = json.loads(data)
    except urllib.error.URLError as e:
        print(f'Error fetching release info: {e}')
        return None

    return release_info

def download_asset(asset_url, dest_folder):
    filename = asset_url.split('/')[-1]
    dest_path = os.path.join(dest_folder, filename)

    try:
        with urllib.request.urlopen(asset_url) as response:
            with open(dest_path, 'wb') as file:
                file.write(response.read())
    except urllib.error.URLError as e:
        print(f'Error downloading asset: {e}')
        return None

    return dest_path

def main():
    repo = 'winnfsd/winnfsd'  # GitHub repo in the format 'owner/repo'
    dest_folder = '.'  # Destination folder for the downloaded file

    release_info = get_latest_release(repo)
    if release_info is None:
        return

    assets = release_info.get('assets', [])

    if not assets:
        print('No assets found for the latest release.')
        return

    # Assuming we want to download the first asset
    asset = assets[0]
    asset_url = asset['browser_download_url']

    print(f'Downloading {asset_url}...')
    downloaded_path = download_asset(asset_url, dest_folder)
    if downloaded_path:
        print(f'File downloaded to {downloaded_path}')
    else:
        print('Failed to download the file.')
        exit(69)

    import shutil
    win_nfsd_path = Path(downloaded_path)
    dest_folder = Path(f"/mnt/c/Dev/tools/")
    dest_folder.parent.mkdir(parents=True, exist_ok=True)
    if win_nfsd_path.exists():
        print(f'Copying WinNFSd.exe to {Path(dest_folder,win_nfsd_path)}...')
        shutil.copy(win_nfsd_path, dest_folder)
         # Clean up the executable
        print(f"Deleting {win_nfsd_exe_path}")
        os.remove(downloaded_path)

    else:
        print(f'WinNFSd.exe not found in {win_nfsd_path}.')
        exit(69)

    win_nfsd_exe_path = Path(dest_folder,win_nfsd_path)
    # Ensure the executable has the correct permissions
    shared_folder = Path("C:\\Dev\\")
    os.chmod(win_nfsd_exe_path, 0o755)
    win_path = str(PureWindowsPath(shared_folder))

    print(win_path)

    run(f'{win_nfsd_exe_path} "{win_path}"')

    WIN_IP = "192.168.0.12"
    mount_cmd = f"mount -o vers=3 -t nfs {WIN_IP}:/c/Dev /mnt/dev"
    run(f'{win_nfsd_exe_path} "{win_path}"')
    print("if daemon can't evert start, use the following cmd from cmd.exe `net stop winnat && net stop winnat`")
    print("if still doesnt work, be sure to read this source code ok?")

    """
    netsh advfirewall firewall add rule name="TCP NFS" dir=in action=allow protocol=TCP localport=1058
    netsh int ipv4 set dynamicport tcp start=35001 num=30535
    net stop winnat
    net start winnat
    netsh int ipv4 add excludedportrange protocol=tcp startport=1058 numberofports=1
    """
     



if __name__ == '__main__':
    main()


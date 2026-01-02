import requests
import zipfile
import os

def download_dataset():
    # Create directories
    os.makedirs("data/raw", exist_ok=True)
    
    # Kaggle direct download URL
    url = "https://storage.googleapis.com/kaggle-data-sets/551609/551799/bundle/archive.zip"
    
    print("Downloading dataset...")
    
    # Download with error handling
    try:
        response = requests.get(url, stream=True)
        response.raise_for_status()  # Check for HTTP errors
        
        # Save file
        zip_path = "data/archive.zip"
        with open(zip_path, "wb") as f:
            for chunk in response.iter_content(chunk_size=8192):
                f.write(chunk)
        
        print(f"Downloaded: {os.path.getsize(zip_path)} bytes")
        
        # Verify it's a valid zip
        print("Verifying zip file...")
        with zipfile.ZipFile(zip_path, 'r') as zip_ref:
            file_list = zip_ref.namelist()
            print(f"Contains {len(file_list)} files")
            
            # Extract
            print("Extracting files...")
            zip_ref.extractall("data/raw")
        
        print("✅ Success! Files extracted to data/raw/")
        
        # Clean up zip
        os.remove(zip_path)
        print("Cleaned up temporary zip file.")
        
    except Exception as e:
        print(f"❌ Error: {e}")
        print("\nTrying alternative download method...")
        alternative_download()

def alternative_download():
    """Alternative direct download"""
    import urllib.request
    
    alt_url = "https://github.com/olist/work-at-olist-data/raw/master/datasets/olist.zip"
    
    try:
        print("Trying alternative source...")
        urllib.request.urlretrieve(alt_url, "data/olist.zip")
        
        with zipfile.ZipFile("data/olist.zip", 'r') as zip_ref:
            zip_ref.extractall("data/raw")
        
        os.remove("data/olist.zip")
        print("✅ Alternative download successful!")
        
    except Exception as e:
        print(f"❌ Alternative also failed: {e}")
        print("\nLast resort: Manual download required.")
        print("1. Go to: https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce")
        print("2. Click 'Download' (1.2GB)")
        print("3. Extract to 'data/raw/' folder")

if __name__ == "__main__":
    download_dataset()
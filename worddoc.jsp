<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Project Documentation Submission</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #6C63FF;
            --accent-color: #00BFA6;
            --dark-color: #2D3748;
            --light-gray: #f8f9fa;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #F7FAFC;
            min-height: 100vh;
            display: flex;
            align-items: center;
            padding: 20px;
        }
        
        .document-container {
            max-width: 1200px;
            margin: 0 auto;
            width: 100%;
            display: flex;
            gap: 30px;
        }
        
        .instructions-panel {
            flex: 1;
            background: white;
            border-radius: 16px;
            padding: 30px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            border-left: 5px solid var(--accent-color);
        }
        
        .form-panel {
            flex: 1;
            background: white;
            border-radius: 16px;
            padding: 30px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            border-left: 5px solid var(--primary-color);
        }
        
        .section-requirement {
            background-color: var(--light-gray);
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 15px;
            border-left: 3px solid var(--primary-color);
        }
        
        .section-title {
            font-weight: 600;
            color: var(--dark-color);
            margin-bottom: 5px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .file-upload-area {
            border: 2px dashed #ddd;
            border-radius: 8px;
            padding: 40px;
            text-align: center;
            margin: 20px 0;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .file-upload-area:hover {
            border-color: var(--primary-color);
            background-color: rgba(108, 99, 255, 0.05);
        }
        
        .upload-icon {
            font-size: 48px;
            color: var(--primary-color);
            margin-bottom: 15px;
        }
        
        .btn-submit {
            background-color: var(--primary-color);
            border: none;
            padding: 12px 24px;
            border-radius: 8px;
            color: white;
            font-weight: 600;
            width: 100%;
            margin-top: 20px;
            transition: all 0.3s ease;
        }
        
        .btn-submit:hover {
            background-color: #5a52e0;
            transform: translateY(-2px);
        }
        
        .requirement-list {
            padding-left: 20px;
        }
        
        .requirement-list li {
            margin-bottom: 8px;
        }
        
        @media (max-width: 768px) {
            .document-container {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <div class="document-container">
        <!-- Instructions Panel -->
        <div class="instructions-panel">
            <h3 class="mb-4"><i class="fas fa-file-word me-2" style="color: var(--accent-color);"></i>Document Requirements</h3>
            
            <p class="mb-4">Please include all the following sections in your Word document:</p>
            
            <div class="section-requirement">
                <div class="section-title">
                    <i class="fas fa-heading"></i>
                    <span>1. Title Page</span>
                </div>
                <p>Project title, your name, institution, and date</p>
            </div>
            
            <div class="section-requirement">
                <div class="section-title">
                    <i class="fas fa-paragraph"></i>
                    <span>2. Abstract (100-200 words)</span>
                </div>
                <p>Brief summary of your project including objectives and outcomes</p>
            </div>
            
            <div class="section-requirement">
                <div class="section-title">
                    <i class="fas fa-search"></i>
                    <span>3. Existing Methodology</span>
                </div>
                <p>Description of current approaches to solving this problem</p>
            </div>
            
            <div class="section-requirement">
                <div class="section-title">
                    <i class="fas fa-project-diagram"></i>
                    <span>4. Diagrams/Flowcharts</span>
                </div>
                <p>Visual representations of your system architecture or workflow</p>
            </div>
            
            <div class="section-requirement">
                <div class="section-title">
                    <i class="fas fa-lightbulb"></i>
                    <span>5. Proposed Methodology</span>
                </div>
                <p>Detailed explanation of your solution and innovation</p>
            </div>
            
            <div class="section-requirement">
                <div class="section-title">
                    <i class="fas fa-layer-group"></i>
                    <span>6. Technology Stack</span>
                </div>
                <p>List of technologies, frameworks, and tools used</p>
            </div>
            
            <div class="section-requirement">
                <div class="section-title">
                    <i class="fas fa-chart-line"></i>
                    <span>7. Results & Analysis</span>
                </div>
                <p>Findings, metrics, and evaluation of your solution</p>
            </div>
            
            <div class="section-requirement">
                <div class="section-title">
                    <i class="fas fa-balance-scale"></i>
                    <span>8. Advantages & Disadvantages</span>
                </div>
                <p>Honest assessment of your solution's strengths and limitations</p>
            </div>
            
            <div class="section-requirement">
                <div class="section-title">
                    <i class="fas fa-book"></i>
                    <span>9. References</span>
                </div>
                <p>Proper citations for all referenced materials</p>
            </div>
            
            <div class="mt-4">
                <h5><i class="fas fa-file-upload me-2"></i>Format Requirements:</h5>
                <ul class="requirement-list">
                    <li>Microsoft Word (.doc or .docx) format only</li>
                    <li>Maximum file size: 10MB</li>
                    <li>Use clear section headings</li>
                    <li>Include page numbers</li>
                    <li>Maintain professional formatting</li>
                </ul>
            </div>
        </div>
        
        <!-- Form Panel -->
        <div class="form-panel">
            <h3 class="mb-4"><i class="fas fa-upload me-2" style="color: var(--primary-color);"></i>Upload Your Document</h3>
            
            <form action="DocumentUploadServlet" method="post" enctype="multipart/form-data">
                <div class="mb-3">
                    <label for="projectTitle" class="form-label fw-bold">Project Title</label>
                    <input type="text" class="form-control" id="projectTitle" name="projectTitle" required>
                </div>
                
                <div class="mb-3">
                    <label for="authorName" class="form-label fw-bold">Author Name(s)</label>
                    <input type="text" class="form-control" id="authorName" name="authorName" required>
                </div>
                
                <div class="file-upload-area" id="dropZone">
                    <input type="file" id="documentFile" name="documentFile" class="d-none" accept=".doc,.docx" required>
                    <label for="documentFile" class="file-label">
                        <div class="upload-icon">
                            <i class="fas fa-file-word"></i>
                        </div>
                        <h5>Drag & drop your Word document here</h5>
                        <p class="text-muted">or click to browse files</p>
                        <div id="fileName" class="fw-bold mt-2"></div>
                        <div id="fileSize" class="small text-muted"></div>
                    </label>
                </div>
                
                <div class="mb-3">
                    <label for="additionalNotes" class="form-label fw-bold">Additional Notes (optional)</label>
                    <textarea class="form-control" id="additionalNotes" name="additionalNotes" rows="3"></textarea>
                </div>
                
                <div class="form-check mb-4">
                    <input class="form-check-input" type="checkbox" id="confirmRequirements" required>
                    <label class="form-check-label" for="confirmRequirements">
                        I confirm this document includes all required sections
                    </label>
                </div>
                
                <button type="submit" class="btn-submit">
                    <i class="fas fa-paper-plane me-2"></i> Submit Documentation
                </button>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // File upload handling
        const fileInput = document.getElementById('documentFile');
        const dropZone = document.getElementById('dropZone');
        const fileName = document.getElementById('fileName');
        const fileSize = document.getElementById('fileSize');
        
        fileInput.addEventListener('change', function(e) {
            if (fileInput.files.length > 0) {
                const file = fileInput.files[0];
                fileName.textContent = file.name;
                fileSize.textContent = (file.size / (1024*1024)).toFixed(2) + 'MB';
                
                // Change drop zone appearance
                dropZone.style.borderColor = 'var(--accent-color)';
                dropZone.style.backgroundColor = 'rgba(0, 191, 166, 0.05)';
            }
        });
        
        // Drag and drop functionality
        dropZone.addEventListener('dragover', (e) => {
            e.preventDefault();
            dropZone.style.borderColor = 'var(--primary-color)';
            dropZone.style.backgroundColor = 'rgba(108, 99, 255, 0.05)';
        });
        
        dropZone.addEventListener('dragleave', () => {
            dropZone.style.borderColor = '#ddd';
            dropZone.style.backgroundColor = 'transparent';
        });
        
        dropZone.addEventListener('drop', (e) => {
            e.preventDefault();
            dropZone.style.borderColor = '#ddd';
            dropZone.style.backgroundColor = 'transparent';
            
            if (e.dataTransfer.files.length) {
                fileInput.files = e.dataTransfer.files;
                const event = new Event('change');
                fileInput.dispatchEvent(event);
            }
        });
    </script>
</body>
</html>
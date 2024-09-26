lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 20.017337337337338 --fixed-mass2 56.660540540540545 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1027987771.6813779 \
--gps-end-time 1027994971.6813779 \
--d-distr volume \
--min-distance 1779.2614153647075e3 --max-distance 1779.2814153647075e3 \
--l-distr fixed --longitude -157.86517333984375 --latitude 45.85395431518555 --i-distr uniform \
--f-lower 20 --disable-spin \
--waveform SEOBNRv4_ROM

bayestar-sample-model-psd \
-o psd.xml \
--H1=aLIGOZeroDetHighPower \
--L1=aLIGOZeroDetHighPower \
--V1=AdvVirgo

bayestar-realize-coincs \
-o coinc.xml \
inj.xml --reference-psd psd.xml \
--detector H1 L1 V1 \
--measurement-error gaussian-noise \
--snr-threshold 4.0 \
--net-snr-threshold 12.0 \
--min-triggers 2 \
--keep-subthreshold

bayestar-localize-coincs coinc.xml
